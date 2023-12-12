class AddNullFalseToReferenceUserToReviews < ActiveRecord::Migration[7.1]
  def change
    change_column_null :reviews, :user_id, false
  end
end
