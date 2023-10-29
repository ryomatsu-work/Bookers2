class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def message
    # if notifiable_type === "Book"
    #   "#{notifiable.user.name} has been posted #{notifiable.title}"
    # elsif notifiable_type === "Favorite"
    #   "#{notifiable.book.title} has been favorited by #{notifiable.user.name}"
    # end
    notifiable.notification_message
  end

  def notifiable_path
    # if notifiable_type === "Book"
    #   book_path(notifiable.id)
    # elsif notifiable_type === "Favorite"
    #   book_path(notifiable.user.id)
    # end
    notifiable.notification_path
  end
end
