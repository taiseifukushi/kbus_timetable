#!/bin/sh
set -e

rm -f /rails_app/tmp/pids/server.pid

bundle exec bin/rails assets:precompile
bundle exec bin/rails assets:clean
# bundle exec bin/rails db:create db:migrate
bundle exec bin/rails server -b 0.0.0.0
