class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.string :title
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
