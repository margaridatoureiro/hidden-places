class Review < ApplicationRecord
  belongs_to :place
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :description, :rating, presence: :true
  validates :rating, inclusion: { in: 0..5 }, numericality: { only_integer: true }
end
