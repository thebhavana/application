class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  has_many_attached :media

  has_many :likes, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_by_users, through: :bookmarks, source: :user

  validates :body, presence: true, length: { minimum: 10 }
  # All callbacks
  before_validation :trim_title_and_body
  before_save :generate_slug
  after_create :log_article_created
  before_destroy :log_deletion

  private def trim_title_and_body    # runs before validation
    self.title = title.strip if title.present?
    self.body = body.strip if body.present?
  end
  private def generate_slug   # runs before save
    puts ">>Article not saved"
  end
  private def log_article_created  # after created
    Rails.logger.info "Article #{title} created at #{created_at}"
    puts " Article is saved"
  end
  private def log_deletion
    puts "it is going to be deleted"
    puts "Deleting post #{id} "
  end
  # Practicing instance methods
  def word_count
    body.to_s.split.size
  end
  def uppercase_title
    title.to_s.upcase
  end
  def brief_intro
    body.to_s.truncate(10)
  end
  # Class methods
  def self.recent_articles
    order(created_at: :desc).limit(5)   # Shows 5 articles
  end
   # This query works on all scopes
   def self.search(query)
     if query.present?
      query = "%#{query.downcase}%"
      where("LOWER(title) LIKE ? OR LOWER(body) LIKE ?", query, query)
     else all
     end
   end
end
