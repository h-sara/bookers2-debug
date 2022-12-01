class Book < ApplicationRecord
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  has_one_attached :image
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
