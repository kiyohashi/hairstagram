class Message < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :rooms
  has_many :users
end
