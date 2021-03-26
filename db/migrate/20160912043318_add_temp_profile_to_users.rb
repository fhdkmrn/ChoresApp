class AddTempProfileToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :temp_profile, :string
  end
end
