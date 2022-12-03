class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # フォローした、されたの関係
  has_many :relationship_er, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :relationship_ed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使用する
  has_many :followings, through: :relationship_er, source: :followed
  has_many :followers, through: :relationship_ed, source: :follower

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end