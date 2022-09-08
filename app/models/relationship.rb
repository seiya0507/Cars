class Relationship < ApplicationRecord

  #class_nameでUserモデルからデータを持ってくる
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

end
