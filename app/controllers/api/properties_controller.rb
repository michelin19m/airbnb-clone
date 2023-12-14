# frozen_string_literal: true

module Api
  class PropertiesController < ApplicationController
    def check_availability
      @property = Property.find(params[:property_id])

      if @property.available?(params[:checkin_date], params[:checkout_date])
        respond_to do |format|
          format.json do
            render json: {}, status: :ok
          end
        end
      else
        respond_to do |format|
          format.json do
            render json: {}, status: :no_content
          end
        end
      end
    end
  end
end