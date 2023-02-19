#!/bin/bash

set -e

rm -f /rails_app/tmp/pids/server.pid

RAILS_ENV=production bundle exec rails assets:precompile
RAILS_ENV=production bundle exec rails assets:clean
RAILS_ENV=production bundle exec rails db:create db:migrate
# データ投入用スクリプトを実行する
bundle exec rails runner script/migrate_csv_data_into_db.rb 
RAILS_ENV=production bundle exec rails server
