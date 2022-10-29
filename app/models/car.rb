class Car < ApplicationRecord

  belongs_to :user
  has_many :car_tags, dependent: :destroy
  has_many :tags, through: :car_tags
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #ActiveStorage設定
  has_one_attached :image

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 200 }
  validates :tag_ids, presence: true
  validates :star, presence: true

  #orderデータ取り出し  desc昇順  asc降順
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

  #star_count星5段階評価順
  scope :star_count, -> {order(star: :desc)}

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
