# Tier List 投稿アプリケーション

このアプリケーションは、ユーザーがさまざまなカテゴリのTier Listを作成、共有できるWebアプリケーションです。
以下にて公開しています。
https://gstonehill.xyz

## 機能

- ユーザー登録と認証
- Tier Listの作成、編集、削除
- 他のユーザーのTier Listの閲覧
- ユーザのフォロー
- Tier Listへのコメント機能(実装予定)
- 人気のTier Listランキング表示(実装予定)

## 使用技術

- Ruby 3.2.3
- Ruby on Rails 7.0.4.3
- その他:関連Gemfileをご参照してください

### ローカル環境でのセットアップ

1. リポジトリをクローンします。

    ```sh
    $ git clone https://github.com/username/tier-list-app.git
    $ cd tier-list-app
    ```

2. dockerコンテナをビルドします。

    ```sh
    $ docker compose build
    ```

3. webサービスコンテナ内に入ります。

    ```sh
    $ docker compose up -d
    $ docker compose exec web bash
    ```


4. webサービスコンテナ内でデータベースをセットアップします。

    ```sh
    $ rails db:create
    $ rails db:migrate
    $ rails db:seed
    $ exit
    ```

初回起動時以外は次のコマンドで実行可能です。

```sh
    $ docker compose up -d
```

開発環境の使用をしないときは次のコマンドでコンテナを停止・削除してください。

```sh
    $ docker compose down
```

### 本番環境でのセットアップ

本番環境で実行するには、以下のコマンドを実行してください。初期化としてマスターキーの生成とパスの設定が必要な場合があります。

```sh
$ set -o errexit
$ bundle install
$ bundle exec rails assets:precompile RAILS_ENV=production
$ bundle exec rails assets:clean RAILS_ENV=production
$ bundle exec rails db:migrate RAILS_ENV=production
```

サンプルユーザが必要な方は下記を実行してください(本番環境での実行は推奨いたしません。)

```sh
$ bundle exec rails db:seed
```

その後、テストを実行してください

```
$ rails test
$ bin/rspec
```

開発環境の場合は下記１行目、本番環境の場合は２行目を実行してください
```sh
$ rails s
```
```sh
$ env RAILS_ENV=production  bundle exec puma -C config/puma.rb &
```
* Ruby version 3.2.3