# frozen_string_literal: true

module Api
  class FavoritesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      favorite = Favorite.create!(favorite_params)

      respond_to do |format|
        format.json do
          render json: serialize_favorite(favorite), status: :created
        end
      end
    end

    def destroy
      favorite = Favorite.find(params[:id])
      favorite.destroy!

      respond_to do |format|
        format.json do
          render json: serialize_favorite(favorite), status: :no_content
        end
      end
    end

    private

    def serialize_favorite(favorite)
      FavoriteSerializer.new(favorite).serializable_hash[:data].to_json
    end

    def favorite_params
      params.permit(:user_id, :property_id)
    end
  end
end