class Property < ApplicationRecord

  geocoded_by :address
  monetize :price_cents, allow_nil: true

  has_many_attached :images, dependent: :destroy

  validates :name, presence: true
  validates :headline, presence: true
  validates :description, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :state, presence: true

  after_validation :geocode, if: ->(obj) { obj.latitude.blank? and obj.longitude.blank? }

  def address
    # [address_1, address_2, city, state, country].compact.join(', ')
    [state, country].compact.join(', ')
  end

  def default_image
    images.first
  end
end
