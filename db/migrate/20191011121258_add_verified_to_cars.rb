class AddVerifiedToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :verified, :boolean, default: false
  end
end
