#!/bin/sh
set -e

rm -f /rails_app/tmp/pids/server.pid
bundle exec rails server -p 3000 -e development --binding=0.0.0.0
