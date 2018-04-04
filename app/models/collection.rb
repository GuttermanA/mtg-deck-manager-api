class Collection < ApplicationRecord
  belongs_to :user
  belongs_to :card
  belongs_to :magic_set
  validates :user_id, uniqueness: true
end
