class Group < ApplicationRecord
  # has_many :group_users
  has_many :users, through: :group_users
  has_one_attached :image_id

  # グループ画像の指定がなかった場合、no_image.jpgを入れる
  def get_group_image
    (image_id.attached?) ? image_id : "no_image.jpg"
  end
end
