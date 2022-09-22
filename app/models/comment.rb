class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :car

  validates :comment, presence: true , length: { munimum: 1, maximum: 30 }

end
