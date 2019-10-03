class CreateConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :conditions do |t|
      t.string :condition, null: false
      t.string :cost, null: false

      #t.timestamps
    end
  end
end
