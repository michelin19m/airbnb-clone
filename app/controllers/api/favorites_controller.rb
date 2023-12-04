# frozen_string_literal: true

module Api
  class FavoritesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      favorite = Favorite.create!(favorite_params)

      respond_to do |format|
        format.json do
          render json: favorite.to_json, status: :created
        end
      end
    end

    def destroy
      favorite = Favorite.find(params[:id])
      favorite.destroy!

      respond_to do |format|
        format.json do
          render json: favorite.to_json, status: :no_content
        end
      end
    end

    private

    def favorite_params
      params.permit(:user_id, :property_id)
    end
  end
end