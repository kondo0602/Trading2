class Item < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  validate :image_presence
  before_save { brand.downcase! }
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 25 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :brand, presence: true
  validates :size, presence: true
  validates :status, presence: true
  validates :user_id, presence: true

  # 商品画像に関するバリデーション
  def image_presence
    if image.attached?
      errors.add(:image, '商品画像はjpegまたはpng形式でアップロードしてください') unless image.content_type.in?(%('image/jpeg image/png'))
    else
      errors.add(:image, '商品画像をアップロードしてください')
    end
  end

  def self.search(search)
    if search
      Item.where(['name LIKE ?', "%#{search}%"])
    else
      Item.all
    end
  end
end
