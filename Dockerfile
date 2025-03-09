FROM ruby:3.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /merchbot_backend
WORKDIR /merchbot_backend
ADD Gemfile /merchbot_backend/Gemfile

ADD Gemfile.lock /merchbot_backend/Gemfile.lock
RUN bundle install
ADD . /merchbot_backend
RUN SECRET_KEY_BASE="assets_compile" RAILS_ENV=production bundle exec rake assets:precompile
CMD RAILS_ENV=production bundle exec rails db:prepare && RAILS_ENV=production bundle exec rails s -p 3000 -b '0.0.0.0'