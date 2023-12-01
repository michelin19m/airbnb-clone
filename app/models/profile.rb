class Profile < ApplicationRecord

  geocoded_by :address

  belongs_to :user

  after_validation :geocode, if: ->(obj) { address.present? && obj.latitude.blank? && obj.longitude.blank? }

  def address
    # [address_1, address_2, city, state, zip_code, country].compact.join(', ')
    [state, country].compact.join(', ')
  end
end
