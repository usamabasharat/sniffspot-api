# frozen_string_literal: true

# Migration to add default value to price column
class AddDefaultValueToPrice < ActiveRecord::Migration[6.1]
  def change
    change_column :spots, :price, :integer, default: 0
  end
end
