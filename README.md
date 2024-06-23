# Ruby On railsチュートリアルのsample_app改良版

これは次の教材で作られたサンプルアプリケーションです。
[*Ruby on Rails チュートリアル*](https://railstutorial.jp/)
( 第７版)
[Michael Hartl](https://www.michaelhartl.com/) 著

##ライセンス

[Ruby on Railsチュートリアル](https://railstutorial.jp/)内にある
ソースコードはMITライセンスとBeerwareライセンスのもとで公開されています。
詳細は[LICENSE.md](LICENSE.md)をご覧ください。

##使い方

このアプリケーションを動かすにはデータベースをマイグレーションを実行します。

、、、
$ rails db:migrate
$ env RAILS_ENV=production bundle exec puma -C config/puma.rb &

、、、

その後、テストを実行してください

、、、
$ rails test
、、、

詳しくは[*Ruby On Railsチュートリアル*](https://railstutorial.jp)を参考にしてください。

* Ruby version 3.2.3