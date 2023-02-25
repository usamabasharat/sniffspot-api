# frozen_string_literal: true

# Add spot_id to Review model
class AddSpotToReview < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :spot
  end
end
