class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_by_users, through: :bookmarks, source: :user
  validates :title, presence: true
  has_many_attached :media

  def self.search(query)
     if query.present?
      query = "%#{query.downcase}%"
      where("LOWER(title) LIKE ? OR LOWER(body) LIKE ?", query, query)
     else all
     end
  end
end
