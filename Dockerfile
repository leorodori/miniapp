FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /miniapp

COPY Gemfile /miniapp/Gemfile
COPY Gemfile.lock /miniapp/Gemfile.lock
RUN bundle install

COPY . /miniapp