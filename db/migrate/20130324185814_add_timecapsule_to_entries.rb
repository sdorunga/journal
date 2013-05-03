class AddTimecapsuleToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :time_capsule, :datetime
  end
end
