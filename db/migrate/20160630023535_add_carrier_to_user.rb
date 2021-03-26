class AddCarrierToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :carrier, :string
  end
end
