# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :spot

  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
end
