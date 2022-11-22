#!/bin/sh
set -e

rm -f /rails_app/tmp/pids/server.pid

RAILS_ENV=production bundle exec rails assets:precompile
RAILS_ENV=production bundle exec rails assets:clean
RAILS_ENV=production bundle exec rails server
