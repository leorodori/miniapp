class ChangeWordNameToText < ActiveRecord::Migration[7.1]
  def change
    change_column :words, :name, :text
  end
end