class CreateYears < ActiveRecord::Migration[5.2]
  def change
    create_table :years do |t|
      t.integer :start, null: false
      t.integer :end, null: false

      #t.timestamps
    end
  end
end
