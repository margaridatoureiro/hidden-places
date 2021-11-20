class Place < ApplicationRecord
  CATEGORIES = %w[Monument Mirador Panoramic Beach Bay Cliff]
  belongs_to :user
  has_many :favourites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :photos
  validates :name, :description, :category, presence: true
  validates :category, inclusion: {in: CATEGORIES, message: "%{value} is not a valid category"}
  include PgSearch::Model
  pg_search_scope :search_by_name_category_address_description,
    against: [ :name, :category, :address, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
