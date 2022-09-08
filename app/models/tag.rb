class Tag < ApplicationRecord

  belongs_to :car
  has_many :car_tags, dependent: :destroy

end
