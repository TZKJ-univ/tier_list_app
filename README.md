# Ruby On railsチュートリアルのsample_app改良版

これは次の教材で作られたアプリケーションです。
[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
( 第７版)
[Michael Hartl](https://www.michaelhartl.com/) 著

##ライセンス

[Ruby on Railsチュートリアル](https://railstutorial.jp/)内にある
ソースコードはMITライセンスとBeerwareライセンスのもとで公開されています。
詳細は[LICENSE.md](LICENSE.md)をご覧ください。

##使い方

本番環境として実行するには下記のコマンドを入力してください。
初期化としてマスターキーの生成とパスを通す作業が必要な場合があります。

、、、
$ set -o errexit
$ bundle install
$ bundle exec rails assets:precompile RAILS_ENV=production
$ bundle exec rails assets:clean RAILS_ENV=production
$ bundle exec rails db:migrate RAILS_ENV=production
$ env RAILS_ENV=production  bundle exec puma -C config/puma.rb &
、、、

サンプルユーザが必要な方は下記を実行してください(本番環境での実行は推奨いたしません。)

、、、
$ bundle exec rails db:seed
、、、

その後、テストを実行してください

、、、
$ rails test
、、、

詳しくは[*Ruby On Railsチュートリアル*](https://railstutorial.jp)を参考にしてください。

* Ruby version 3.2.3