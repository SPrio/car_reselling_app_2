class AddSoldToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :sold, :boolean, default: false
  end
end
