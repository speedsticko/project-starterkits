FROM ruby:2.3.3
MAINTAINER klim@learnersleague.com

# Install dependencies required by Rails and RubyGems
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

# Define the working directory for future CMD, RUN, COPY, and ENTRYPOINT commands.
RUN mkdir -p /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install
COPY . /app
