FROM miriamtech/passenger-ruby27:latest

ENV PROJECT_NAME=table_locks
ENV PATH="/home/app/${PROJECT_NAME}/bin:${PATH}"

ARG EXTRA_RUBY_VERSIONS="2.5.9"
RUN set -eu; for ruby in $EXTRA_RUBY_VERSIONS; do bash -lc "rvm install $ruby"; done

# Make sure we're on a new enough rubygems for Rails edge, but old enough to support Ruby 2.5.
ARG RUBYGEMS_VERSION=3.3.26
RUN bash -lc "rvm @global do gem update --system \"$RUBYGEMS_VERSION\""
RUN set -eu; for ruby in $EXTRA_RUBY_VERSIONS; do setuser app bash -lc "rvm $ruby@global do gem update --system \"$RUBYGEMS_VERSION\""; done

# Install the app's gems
WORKDIR /home/app/${PROJECT_NAME}
RUN chown app:app /home/app/${PROJECT_NAME}
ADD --chown=app .bundle Gemfile* *.gemspec /home/app/${PROJECT_NAME}/
ADD --chown=app lib/table_locks/version.rb lib/table_locks/
RUN setuser app bundle config set --local deployment true
RUN setuser app bundle install

ADD --chown=app . /home/app/table_locks
