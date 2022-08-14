#!/bin/bash
set -e

# 環境設定をする
# https://devcenter.heroku.com/ja/articles/config-vars#managing-config-vars
heroku config:set RAILS_ENV=production

# production環境のDBを作成する
RAILS_ENV=production bundle exec rails db:drop db:create db:migrate db:seed
