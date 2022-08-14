#!/bin/bash
set -e

# 環境設定をする
# https://devcenter.heroku.com/ja/articles/config-vars#managing-config-vars
heroku config:set RAILS_ENV=production

# production環境のDBを作成する
RAILS_ENV=production bundle exec rails db:drop db:create db:migrate db:seed

# pumaを使ってサーバーを起動
# https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#config
RAILS_ENV=production bundle exec puma -C config/puma.rb