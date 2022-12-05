class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  has_one_attached :image
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

    # 検索をする処理
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE ?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE ?", "#{word}%")
    elsif search == "back_match"
      @book = Book.where("title LIKE ?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE ?", "%#{word}%")
    end
  end

end