class User < ApplicationRecord
   has_many :articles, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
