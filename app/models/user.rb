class User < ApplicationRecord
  has_secure_password

  has_many :words, dependent: :destroy
  
  has_many :folders, dependent: :destroy

  validates :email, presence: true

  def own?(word)
    word.user_id == id
  end
end