class AddNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :number, :string, limit: 10, null: false
  end
end
