class Word < ApplicationRecord
  belongs_to :user
  belongs_to :folder, optional: true

  validates :name, presence: true, length: { maximum: 100 }

  has_many :notes, dependent: :destroy

  def owned_by?(user)
    user_id == user.id
  end
end