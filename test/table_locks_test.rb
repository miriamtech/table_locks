require 'test_helper'

class TableLocksTest < ActiveSupport::TestCase

  def setup
    @threads = []
    @monitor = Monitor.new
  end

  def test_exclusive
    completion_order = []
    thread do
      TableLockModel.exclusive do
        # Second thread launched while lock held should be blocked until we finish
        thread do
          TableLockModel.exclusive do
            completion_order << 2
          end
        end
        sleep(1)
        completion_order << 1
      end
    end
    wait_for_threads
    assert_equal [1, 2], completion_order
  end

  def test_exclusive_nowait
    thread1_entered = false
    thread1_entered_cond = @monitor.new_cond
    thread2_exited = false
    thread2_exited_cond = @monitor.new_cond
    thread do
      TableLockModel.exclusive_nowait do
        @monitor.synchronize do
          thread1_entered = true
          thread1_entered_cond.signal
        end
        @monitor.synchronize do
          thread2_exited_cond.wait(2) unless thread2_exited
        end
      end
    end
    thread do
      begin
        @monitor.synchronize do
          thread1_entered_cond.wait(2) unless thread1_entered
        end
        assert_raise PG::LockNotAvailable do
          TableLockModel.exclusive_nowait do
            flunk "Body of block shouldn't be run if lock was not available"
          end
        end
      ensure
        @monitor.synchronize do
          thread2_exited = true
          thread2_exited_cond.signal
        end
      end
    end
    wait_for_threads
    assert thread1_entered
    assert thread2_exited
  end

  private

  def thread(&block)
    thread = Thread.new(&block)
    @monitor.synchronize { @threads << thread }
  end

  def wait_for_threads
    loop do
      break if @monitor.synchronize { @threads.size == 2 }
      sleep(0.1)
    end
    loop do
      break unless thread = @monitor.synchronize { @threads.pop }
      thread.join
    end
  end
end
