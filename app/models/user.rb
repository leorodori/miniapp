class User < ApplicationRecord
  has_secure_password
  has_many :words

  validates :email, presence: true

  def own?(word)
    word.user_id == id
  end
end