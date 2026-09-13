class Word < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 100 }

  def owned_by?(user)
    user_id == user.id
  end
end