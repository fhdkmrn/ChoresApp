class AddAcceptedTradeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :acceptedTrade, :string, array: true, default: []
  end
end
