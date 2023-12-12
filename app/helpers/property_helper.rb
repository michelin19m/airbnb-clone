module PropertyHelper
  def property_rating_percentage(property:, rating:)
    (property.reviews.where(rating: rating).length.to_f / property.reviews_count * 100).to_i
  end
end