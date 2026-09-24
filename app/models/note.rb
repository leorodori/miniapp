class Note < ApplicationRecord
  belongs_to :word

  validates :body, presence: true, length: { maximum: 300 }
end