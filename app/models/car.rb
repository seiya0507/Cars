class Car < ApplicationRecord

  belongs_to :user
  has_many :tags, dependent: :destroy
  has_many :car_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #ActiveStorage設定
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
