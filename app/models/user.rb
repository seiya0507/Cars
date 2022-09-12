class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーション
  has_many :cars, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :freeze, dependent: :destroy

  #フォロワー foreign_keyで参照するカラム指定
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #フォロー
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  #一覧ページで使用
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower


  #ActiveStorage
  has_one_attached :profile_image, dependent: :destroy


  #バリデーション
  #validates :name, presence: true, uniqueness: true, length: { munimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }


  def self.guest
    #()の条件を返す・新規作成を繰り返すメソッド
    find_or_create_by!(name: 'guestuser', email: 'guest@example.com') do |user|
                      #ランダムな文字列を生成するメソッド
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

end
