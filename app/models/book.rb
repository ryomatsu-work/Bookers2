class Book < ApplicationRecord
  include Notifiable
  belongs_to :user
  has_many :favorites
  has_many :book_comments
  has_many :page_views
  has_many :book_tag_relations, dependent: :destroy
  has_many :tags, through: :book_tag_relations, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  after_create do
    records = user.follower_users.map do |follower|
      # notifications.create!(user_id: follower.id)
      notifications.new(user_id: follower.id)
    end
    Notification.import records
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def notification_message
    "#{user.name} has been posted #{title}"
  end

  def notification_path
    book_path(self)
  end

end
