#!/bin/bash

set -e

rm -f /rails_app/tmp/pids/server.pid
bundle exec rails db:create db:migrate
bundle exec rails runner script/migrate_csv_data_into_db.rb 
bundle exec rails server -p 3000 --binding=0.0.0.0
