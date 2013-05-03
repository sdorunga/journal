class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :name
      t.string :title
      t.integer :price

      t.timestamps
    end
  end
end
