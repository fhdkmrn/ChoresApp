class AddTempProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :temp_profile, :string
  end
end
