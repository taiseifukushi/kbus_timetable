#!/bin/sh
set -e

rm -f /rails_app/tmp/pids/server.pid

bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:create db:migrate
bundle exec rails server -b 0.0.0.0
