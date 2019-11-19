FROM ruby:2.6.5
MAINTAINER klim@learnersleague.com

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# Install dependencies required by Rails and RubyGems
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  ghostscript

# Define the working directory for future CMD, RUN, COPY, and ENTRYPOINT commands.
RUN mkdir -p /app
RUN mkdir -p /usr/local/nvm
WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get install -y nodejs

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

RUN npm install -g yarn
RUN yarn install --check-files
COPY . /app
