class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :points, :integer
    add_column :users, :phone, :string
  end
end
