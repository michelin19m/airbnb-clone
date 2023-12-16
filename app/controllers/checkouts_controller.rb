# frozen_string_literal: true

class CheckoutsController < ApplicationController

  # TODO: Prepurchase reservation to avoid conflicts between users.
  def create
    @property = Property.find(params[:property_id])
    # prepurchase_reservation

    session = Stripe::Checkout::Session.create({
      success_url: 'https://fancy-walrus-enhanced.ngrok-free.app/checkouts/success?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: "https://fancy-walrus-enhanced.ngrok-free.app/properties/#{@property.id}",
      metadata: {
        property_id: @property.id,
        check_in: params[:start],
        checkout: params[:end],
        user_id: current_user.id
      },
      customer_email: current_user.email,
      line_items: [
        {
          quantity: 1,
          price_data: {
            currency: 'usd',
            unit_amount: calculated_price,
            product_data: {
              name: "#{@property.headline} in #{@property.city}, #{@property.country} (#{params[:start]} - #{params[:end]})",
              images: ["https://fancy-walrus-enhanced.ngrok-free.app/rails/active_storage/blobs/#{@property.images.first.signed_id}/#{@property.images.first.filename}"]
            }
          }
        },
      ],
      mode: 'payment',
    })
    redirect_to session.url, allow_other_host: true, status: 303
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])

    @reservation = Reservation.create(
      property_id: session.metadata.property_id,
      user_id: session.metadata.user_id,
      start_date: session.metadata.check_in,
      end_date: session.metadata.checkout
    )
  end

  private

  def calculated_price
    full_stay_price = @property.price_cents * (Date.parse(params[:end]) - Date.parse(params[:start])).days.in_days.to_i
    full_stay_price -= full_stay_price % 100
    (full_stay_price + full_stay_price * Property::SERVICE_FEE_PERCENTAGE + Property::CLEANING_FEE).round
  end
end