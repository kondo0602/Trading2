class Like < ApplicationRecord
  belongs_to :item
  belongs_to :user
  # 一人がひとつの投稿に1つしかいいねできない
  validates_uniqueness_of :item_id, scope: :user_id
end
