class Favorite < ApplicationRecord
  include Notifiable
  belongs_to :user
  belongs_to :book

  has_one :notification, as: :notifiable, dependent: :destroy

  after_create do
    create_notification(user_id: book.user_id)
  end

  def notification_message
    "#{book.title} has been favorited by #{user.name}"
  end

  def notification_path
    user_path(user)
  end
end
