class AddDeclinedTradeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :declinedTrade, :string, array: true, default: []
  end
end
