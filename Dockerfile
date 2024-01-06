ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

WORKDIR /application

FROM base as build

RUN apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
      build-essential \
      git \
      gpg \
      curl \
      openssl \
      ca-certificates \
      tzdata \
      lsb-release && \
      curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgresql-keyring.gpg && \
      echo "deb [signed-by=/usr/share/keyrings/postgresql-keyring.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
      > /etc/apt/sources.list.d/pgdg.list && \
      apt-get update && \
      apt-get install --no-install-recommends -y libpq-dev postgresql-client-16 redis-tools && \
      apt-get purge -y lsb-release && \
      apt-get autoremove -y && \
      rm -rf /var/lib/apt/lists/*

RUN gem install bundler:2.4.21

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["./bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
