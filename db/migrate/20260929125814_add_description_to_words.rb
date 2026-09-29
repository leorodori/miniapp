class AddDescriptionToWords < ActiveRecord::Migration[7.1]
  def change
    add_column :words, :description, :text
  end
end
