class AddTradeRequestsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tradeRequests, :string, array: true, default: []
  end
end
