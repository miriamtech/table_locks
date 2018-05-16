module TableLocks
  extend ActiveSupport::Concern

  class_methods do

    def exclusive(&block)
      connection_pool.with_connection do |c|
        transaction do
          c.execute "LOCK TABLE #{table_name} IN SHARE UPDATE EXCLUSIVE MODE"
          yield
        end
      end
    end

    def exclusive_nowait(&block)
      connection_pool.with_connection do |c|
        transaction do
          begin
            logger = c.logger || ActiveSupport::Logger.new(STDOUT)
            logger.silence(Logger::FATAL) do
              c.execute "LOCK TABLE #{table_name} IN SHARE UPDATE EXCLUSIVE MODE NOWAIT"
            end
            yield
          rescue ActiveRecord::StatementInvalid => e
            if e.cause.is_a?(PG::LockNotAvailable)
              raise e.cause
            else
              raise
            end
          end
        end
      end
    end

  end
end
