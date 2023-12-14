class Reservation < ApplicationRecord
  belongs_to :property
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :future_booked_dates, -> { where("reservation_date > ?", Date.today).order(:start_date) }
end
