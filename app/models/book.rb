class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :book_comments
  has_many :page_views
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
