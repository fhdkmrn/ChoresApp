class CreateChoreLists < ActiveRecord::Migration
  def change
    create_table :chore_lists do |t|
      t.text :options
    end
  end
end
