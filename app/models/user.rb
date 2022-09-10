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


  #ActiveStorage設定
  has_one_attached :profile_image

  def self.guest
    #()の条件を返す・新規作成を繰り返すメソッド
    find_or_create_by!(name: 'guestuser', email: 'guest@example.com') do |user|
                      #ランダムな文字列を生成するメソッド
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

end
