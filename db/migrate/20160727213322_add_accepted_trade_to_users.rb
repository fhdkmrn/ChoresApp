class AddAcceptedTradeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :acceptedTrade, :string, default: [].to_yaml, array: true
  end
end
