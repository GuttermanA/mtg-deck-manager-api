class Collection < ApplicationRecord
  belongs_to :user
  belongs_to :card
  belongs_to :set
  validates :user_id, uniqueness: true
end
