#!/bin/sh
set -e

rm -f /rails_app/tmp/pids/server.pid

if [${RAILS_ENV} == "production"]; then
    bundle exec rails assets:precompile
    bundle exec rails db:migrate RAILS_ENV=production
    bundle exec rails server -b 0.0.0.0 RAILS_ENV=production
else
    bundle exec rails server -b 0.0.0.0
fi