# Ruby On railsによるTier list投稿アプリケーション

##使い方

本番環境として実行するには下記のコマンドを[RAILS_ENV=production]を含めて入力してください。
初期化としてマスターキーの生成とパスを通す作業が必要な場合があります。

、、、
$ set -o errexit
$ bundle install
$ bundle exec rails assets:precompile RAILS_ENV=production
$ bundle exec rails assets:clean RAILS_ENV=production
$ bundle exec rails db:migrate RAILS_ENV=production
、、、

サンプルユーザが必要な方は下記を実行してください(本番環境での実行は推奨いたしません。)

、、、
$ bundle exec rails db:seed
、、、

その後、テストを実行してください

、、、
$ rails test
、、、

開発環境の場合は下記１行目、本番環境の場合は２行目を実行してください
、、、
$ rails s
$ env RAILS_ENV=production  bundle exec puma -C config/puma.rb &
、、、

詳しくは[*Ruby On Railsチュートリアル*](https://railstutorial.jp)を参考にしてください。

* Ruby version 3.2.3