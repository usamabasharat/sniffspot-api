# frozen_string_literal: true

# Spot serializer class
class SpotSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :reviews, :image_urls, :average_rating

  def reviews
    object.reviews
  end
end
