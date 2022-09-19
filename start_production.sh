#!/bin/sh
set -e

rm -f /rails_app/tmp/pids/server.pid

bundle exec rails assets:precompile
bundle exec rails assets:clean
/bin/production
