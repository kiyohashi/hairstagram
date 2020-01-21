<img src="https://cdn-images-1.medium.com/max/959/1*Qc0XxYm-qAZL-7tjjlNfrg.png" width="100"><img src="http://i2.wp.com/samancha.com/wp-content/uploads/2017/12/rails.png?fit=600%2C600" width="100"><img src="http://f.st-hatena.com/images/fotolife/n/nipe880324/20141001/20141001005928.png?1412092889" width="140"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Sass_Logo_Color.svg/1200px-Sass_Logo_Color.svg.png" width="100"><img src="https://www.mysql.com/common/logos/logo-mysql-170x115.png" width="140"><img src="https://a0.awsstatic.com/libra-css/images/logos/aws_logo_smile_1200x630.png" width="100"><img src="https://getbootstrap.jp/docs/4.2/assets/brand/bootstrap-solid.svg" width="100">

Name
====
HairStagram(仮)

## 製作経緯
プロのセットは参考にならない。

## 詳細
カタログ等のヘアセットは作り込まれているしスキルも高い。

一般の方には、ハードルが高いし、日々そんなに時間もない。

そこで一般の方による、より日常に近いヘアセットを投稿できるSNS型アプリを作成しました。

ユーザーまた、投稿にサロンを登録することにより、サロンのお客さんの層やそのサロンのスタイルがわかります。
美容室選び、またスタイルの相談の際、資料となりスムーズにイメージを共有できるようになります。

また使用したアイテムを登録して投稿することにより、その投稿自体がそのままワックスや美容家電のサンプルとなり
消費者の購入の手助けとなります。



### URL
http://18.176.201.68/

## sample_login_account
- mail: test@gmail.com
- pass: 00000000


## Environment
- Ruby 2.5.1
- Rails 5.2.4
- Haml
- SCSS
- JavaScript 
- MySQL
- jQuery 
- ajax 非同期通信
- AWS EC2, S3, 
- capistrano (Automatic deployment)

## Function
- ユーザー新規登録
- ログイン
- ログアウト
- ユーザープロフィール、編集、削除
<img width="2882" alt="スクリーンショット 2020-01-19 0 53 22のコピー" src="https://user-images.githubusercontent.com/56781869/72678188-e5c4f200-3ae6-11ea-8052-69f05d2b9f97.png">

- ダイレクトメッセージ機能
<img width="1440" alt="スクリーンショット 2020-01-19 0 47 25" src="https://user-images.githubusercontent.com/56781869/72678504-ea3eda00-3ae9-11ea-994b-a0da12ee9400.png">

- スタイルの投稿、削除
<img width="2880" alt="スクリーンショット 2020-01-19 18 40 41のコピー" src="https://user-images.githubusercontent.com/56781869/72678853-190a7f80-3aed-11ea-8773-d1b03b77c50c.png">

- コメント機能、削除
- いいね機能
- フォロー機能
- ランキング
<img width="1440" alt="スクリーンショット 2020-01-19 0 39 33" src="https://user-images.githubusercontent.com/56781869/72678540-3f7aeb80-3aea-11ea-98d6-013c83172772.png">

- タイムライン
<img width="1440" alt="スクリーンショット 2020-01-19 0 45 52" src="https://user-images.githubusercontent.com/56781869/72678532-1eb29600-3aea-11ea-88b6-05fc5598534b.png">

- 検索機能(ユーザー、スタイル、サロン、アイテム)
<img width="2880" alt="スクリーンショット 2020-01-19 0 50 18のコピー" src="https://user-images.githubusercontent.com/56781869/72678626-0f801800-3aeb-11ea-89b6-f7c2585bdd64.png">

- スクレイピング(mechanize使用)
- ページネーション(kaminari使用)
- 自動デプロイ(capistrano使用)


## gem
- gem 'pry-rails'
- gem 'compass-rails', '3.1.0'
- gem 'sprockets', '3.7.2'
- gem 'devise'
- gem 'carrierwave'
- gem 'mini_magick'
- gem 'fog-aws'
- gem 'bootstrap'
- gem 'jquery-rails'
- gem 'font-awesome-sass', '~> 5.4.1'
- gem "acts_as_follower", github: "tcocca/acts_as_follower"
- gem 'mechanize'
- gem 'kaminari'
- gem 'active_hash'
- gem 'haml-rails'
- gem 'sass-rails', '5.0.7'
- gem 'jbuilder', '~> 2.5'
- gem 'capistrano'
- gem 'capistrano-rbenv'
- gem 'capistrano-bundler'
- gem 'capistrano-rails'
- gem 'capistrano3-unicorn'
- gem 'unicorn', '5.4.1'



## Goal diary DB設計
<img width="1303" alt="スクリーンショット 2020-01-18 19 51 01" src="https://user-images.githubusercontent.com/56781869/72677034-2b7bbd80-3adb-11ea-89fd-3ab27af98bd5.png">


## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|acountid|string|null: false|
|icon|text|
|email|string|null: false|
|password|string|null: false|
|gender|integer|null: false|
|introduction|string|null: false|
|salon_id|integer|null: false, foreign_key: true|

### Association
- has_many :posts
- has_many :comments
- has_many :favorites
- has_many :follows
- belongs_to :salon


## favoritesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|string|foreign_key: true|
|post_id|string|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :post


## postsテーブル

|Column|Type|Options|
|------|----|-------|
|body|text|
|user_id|integer|null: false, foreign_key: true|
|salon_id|string|null: false, foreign_key: true|

### Association
- has_many :favorites
- has_many :comments
- has_many :images
- has_many :styles through: posts_styles
- belongs_to :user
- belongs_to :salon

## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|text|
|post_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :post


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|body|text|
|image|text|
|user_id|integer|null: false, foreign_key: true|
|post_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :post


## posts_stylesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|style_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :style
- belongs_to :post


## styles テーブル

|Column|Type|Options|
|------|----|-------|
|name|string|
|gender|integer|

### Association
- has many :posts through: posts_styles


## follows テーブル

|Column|Type|Options|
|------|----|-------|
|users_id|integer|null: false, foreign_key: true|
|follows_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user


## salons テーブル

|Column|Type|Options|
|------|----|-------|
|name|integer|null: false|
|adress|integer|null: false|

### Association
- has_many :users
- has_many :posts

