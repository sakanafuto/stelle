FROM ruby:2.6.5

RUN apt-get update && \
    apt-get install -y mysql-client nodejs vim --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /myworkspace

WORKDIR /myworkspace

ADD Gemfile /myworkspace/Gemfile
ADD Gemfile.lock /myworkspace/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /myworkspace