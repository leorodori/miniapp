class AddFolderToWords < ActiveRecord::Migration[7.1]
  def change
    add_reference :words, :folder, null: true, foreign_key: true
  end
end