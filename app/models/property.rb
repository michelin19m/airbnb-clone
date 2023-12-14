# frozen_string_literal: true

class Property < ApplicationRecord

  CLEANING_FEE = 5_000.freeze
  CLEANING_FEE_MONEY = Money.new(CLEANING_FEE)
  SERVICE_FEE_PERCENTAGE = 0.08.freeze

  geocoded_by :address
  monetize :price_cents, allow_nil: true

  has_many_attached :images, dependent: :destroy
  has_many :reviews, as: :reviewable
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :reservations, dependent: :destroy
  has_many :reserved_users, through: :reservations, source: :user

  validates :name, presence: true
  validates :headline, presence: true
  validates :description, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :state, presence: true

  after_validation :geocode, if: ->(obj) { obj.latitude.blank? and obj.longitude.blank? }

  # TODO: when there will be real data (not FAKER)
  def address
    # [address_1, address_2, city, state, country].compact.join(', ')
    [state, country].compact.join(', ')
  end

  def default_image
    images.first
  end

  def favorited_by?(user)
    return false if user.nil?

    favorited_users.include?(user)
  end

  # TODO: make this work properly
  def available_dates(nights=3)
    # next_reservation = reservations.future_booked_dates(nights).first
    date_format = "%b %e"
    # return Date.tomorrow.strftime(date_format)..(Date.tomorrow + nights.days).strftime(date_format) if next_reservation.nil? || (next_reservation.start_date - nights.days) < Date.tomorrow

    # Date.tomorrow.strftime(date_format)..next_reservation.reservation_date.strftime(date_format)
    return Date.tomorrow.strftime(date_format)..(Date.tomorrow + nights.days).strftime(date_format)
  end

  def available?(start_date, end_date)
    conflicting_reservations = reservations.where(
      '(? <= end_date) AND (? >= start_date)',
      start_date, end_date
    )

    conflicting_reservations.empty?
  end
end
