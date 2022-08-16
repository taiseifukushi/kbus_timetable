FROM ruby:3.1

RUN mkdir /rails_app
WORKDIR /rails_app
COPY Gemfile /rails_app/Gemfile
COPY Gemfile.lock /rails_app/Gemfile.lock
RUN bundle install
RUN apt-get update && apt-get -y install vim
COPY . /rails_app

COPY start.sh /usr/bin/
RUN chmod +x /usr/bin/start.sh
EXPOSE 3000
CMD [ "sh", "start.sh" ]
