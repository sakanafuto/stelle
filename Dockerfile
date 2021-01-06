FROM ruby:2.6.5

RUN apt update -qq && \
    apt install -y  build-essential \ 
                        libpq-dev \        
                        nodejs           

RUN mkdir /stelle
ENV APP_ROOT /stelle
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN gem install bundler
RUN bundle install
COPY . $APP_ROOT