class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :color
      t.integer :hp
      t.string :model

      t.timestamps null: false
    end
  end
end
