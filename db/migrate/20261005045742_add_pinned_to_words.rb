class AddPinnedToWords < ActiveRecord::Migration[7.1]
  def change
    add_column :words, :pinned, :boolean, null: false, default: false
  end
end