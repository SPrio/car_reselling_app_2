class CreateKilometerRanges < ActiveRecord::Migration[5.2]
  def change
    create_table :kilometer_ranges do |t|
      t.string :name, null: false

      #t.timestamps
    end
  end
end
