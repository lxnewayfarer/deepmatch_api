FROM ruby:3.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /deepmatch-backend
WORKDIR /deepmatch-backend
ADD Gemfile /deepmatch-backend/Gemfile

ADD Gemfile.lock /deepmatch-backend/Gemfile.lock
RUN bundle install
ADD . /deepmatch-backend
RUN SECRET_KEY_BASE="assets_compile" RAILS_ENV=production bundle exec rake assets:precompile
CMD RAILS_ENV=production bundle exec rails db:prepare && RAILS_ENV=production bundle exec rails s -p 3000 -b '0.0.0.0'