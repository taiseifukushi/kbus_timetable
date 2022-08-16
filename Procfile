release: bundle exec rails db:migrate RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1
web: bundle exec puma -C config/puma.rb -e production
