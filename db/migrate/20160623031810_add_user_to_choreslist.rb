class AddUserToChoreslist < ActiveRecord::Migration[5.1]
  def change
    add_column :choreslists, :user, :string
  end
end
