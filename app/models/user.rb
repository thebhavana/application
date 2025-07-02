class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :article
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_articles, through: :bookmarks, source: :article

  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages

  has_many :articles, dependent: :destroy
   has_one_attached :profile_picture
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[admin author]
  def admin?
    role == "admin"
  end
  def author?
    role == "author"
  end
end
