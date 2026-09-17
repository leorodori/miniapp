class Note < ApplicationRecord
  belongs_to :word

  validates :body, presence: true
end