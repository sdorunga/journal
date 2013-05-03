class AddWordsColumnToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :words, :integer
  end
end
