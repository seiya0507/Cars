class Car < ApplicationRecord

  belongs_to :user
  has_many :car_tags, dependent: :destroy
  has_many :tags, through: :car_tags
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #ActiveStorage設定
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :tag_ids, presence: true

                   #空を許可
  validates :star, numericality: true


  #いいねメソッド
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  #キーワード検索メソッド
  def self.search_for(content, method)
    if method == 'perfect'
      Car.where(title: content)
    elsif method == 'forward'
      Car.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Car.where('title LIKE ?', '%'+content)
    else
      Car.where('title LIKE ?', '%'+content+'%')
    end
  end
end
