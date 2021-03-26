class CreateChoreslists < ActiveRecord::Migration[5.1]
  def self.up
    add_column :assessments, :options, :string
  end

  def self.down
    remove_column :assessments, :options
  end

  def change

    create_table :choreslists do |t|

      t.timestamps null: false
    end
  end
end
