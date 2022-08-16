FROM ruby:3.1

RUN mkdir /rails_app
WORKDIR /rails_app
COPY Gemfile /rails_app/Gemfile
COPY Gemfile.lock /rails_app/Gemfile.lock
RUN bundle install
RUN apt-get update && apt-get -y install vim
COPY . /rails_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# ENV RAILS_ENV="production"
# ENV RAILS_SERVE_STATIC_FILES=1
CMD ["rails", "server", "-b", "0.0.0.0"]