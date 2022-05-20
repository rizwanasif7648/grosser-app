FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y nodejs && apt-get -y install cron
RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler

RUN bundle install
COPY . .

EXPOSE 3000

LABEL maintainer="Omer Aslam <omer.aslam@clustox.com>"

RUN cron

# Migrate our app
CMD RAILS_ENV=${RAILS_ENV} bundle exec rails db:migrate
