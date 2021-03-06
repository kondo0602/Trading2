class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_items, through: :likes, source: :item
  has_many :comments, dependent: :destroy
  has_many :dms, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_one_attached :image
  before_save { email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    # 有効なメールアドレスの正規表現
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :address,  presence: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # def already_liked?(item, current_user)
  #   l = Like.find_by(item_id: item.id, user_id: current_user.id)
  #   binding.pry
  # end

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end
  # 魔法
  has_secure_password
end
