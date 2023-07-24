class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :followers, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
  has_many :followeds, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy

  has_many :follower_users, through: :followers, source: :followed
  has_many :followed_users, through: :followeds, source: :follower

  has_many :senders, class_name: 'DirectMessage', foreign_key: :sender_user_id, dependent: :destroy
  has_many :receivers, class_name: 'DirectMessage', foreign_key: :receiver_user_id, dependent: :destroy

  has_many :sender_users, through: :senders, source: :receiver
  has_many :receiver_users, through: :receivers, source: :sender

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def follow?(user_id)
    followers.find_by(followed_id: user_id).present?
  end

  def followed_by?(user_id)
    followeds.find_by(follower_id: user_id).present?
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
