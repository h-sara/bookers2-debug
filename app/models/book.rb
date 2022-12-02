class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  has_one_attached :image
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end