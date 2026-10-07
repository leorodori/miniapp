class Folder < ApplicationRecord
  belongs_to :user
  has_many :words, dependent: :nullify
  validates :name, presence: true, uniqueness: { scope: :user_id }
end