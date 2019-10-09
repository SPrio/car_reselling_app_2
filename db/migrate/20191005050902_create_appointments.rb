class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.string :status 
      t.integer :who_user_id, null:false
      t.integer :whom_user_id, null:false
      t.references :car, null: false, foreign_key: true

      #t.timestamps
    end
  end
end
