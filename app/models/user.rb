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

end
