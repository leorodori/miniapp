class AddUserIdToWords < ActiveRecord::Migration[7.1]
  def change
    add_reference :words, :user, null: true, foreign_key: true
  end
end