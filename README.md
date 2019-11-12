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
|image|text|
|user_id|integer|null: false, foreign_key: true|
|salon_id|string|null: false, foreign_key: true|

### Association
- has_many :favorites
- has_many :comments
- has_many :styles through: posts_styles
- belongs_to :user
- belongs_to :salon


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
|name|integer|
|gender|enum|

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

