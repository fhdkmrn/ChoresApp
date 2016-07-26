class AddUserToChoreslist < ActiveRecord::Migration
  def change
    add_column :choreslists, :user, :string
  end
end
