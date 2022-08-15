# #!/bin/bash
# set -e

# # 環境設定をする
# # https://devcenter.heroku.com/ja/articles/config-vars#managing-config-vars
# echo "heroku config:set RAILS_ENV=production"
# heroku config:set RAILS_ENV=production

# # production環境のDBを作成する
# echo "heroku run bundle exec rails db:drop db:create db:migrate db:seed RAILS_ENV=production"
# heroku run bundle exec rails db:drop db:create db:migrate db:seed RAILS_ENV=production

# echo "heroku ps"
# heroku ps