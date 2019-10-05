class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.integer :year, null: false
      t.string :quotation
      t.string :brand, null: false
      t.string :model, null: false
      t.string :city, null: false
      t.string :condition, null: false
      t.string :kilometer_range, null: false
      t.string :state, null: false
      t.string :variant, null: false
      t.string :status, default: "not verified"
      t.references :user, null: false, foreign_key: true

      #t.timestamps
    end
  end
end
