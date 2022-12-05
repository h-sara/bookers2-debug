class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # フォローした、されたの関係
  has_many :followings, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使用する
  has_many :followings_users, through: :followings, source: :followed
  has_many :followers_users, through: :followers, source: :follower

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  # フォローした時の処理
  def follow(user_id)
    followings.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    followings.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings_users.include?(user)
  end
  # 検索をする処理（完全一致）
  def self.looks(word) #def looks(search, word)
    @user = User.where("name LIKE ?", "#{word}")
  end

end