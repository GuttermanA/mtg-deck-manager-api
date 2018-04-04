class Color < ApplicationRecord
  has_and_belongs_to_many :cards
  validates :name, uniqueness: true, presence: true
end
