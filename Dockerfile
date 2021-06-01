FROM miriamtech/passenger-ruby25

# Add application
ADD lib /home/app/table_locks/lib
#ADD Gemfile Gemfile.lock table_locks.gemspec /home/app/table_locks/
ADD Gemfile table_locks.gemspec /home/app/table_locks/
WORKDIR /home/app/table_locks
RUN bundle install

ADD . /home/app/table_locks
