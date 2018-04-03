class Set < ApplicationRecord
  has_many :cards
  has_many_and_belongs_to_many :cards
  validates :name, uniqueness: true
end
