# frozen_string_literal: true

# Spot model
class Spot < ApplicationRecord
  has_many_attached :images, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :images, content_type: ['image/png', 'image/jpeg', 'image/jpg']

  def image_urls
    images.map { |image| Rails.application.routes.url_helpers.url_for(image) }
  end

  def average_rating
    reviews.average(:rating)&.round(1) || 0.0
  end
end
