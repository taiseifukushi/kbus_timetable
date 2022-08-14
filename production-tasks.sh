rm -f tmp/pids/server.pid
RAILS_ENV=production bundle exec rails db:drop db:create db:migrate db:seed
