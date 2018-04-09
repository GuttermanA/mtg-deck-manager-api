class Format < ApplicationRecord
  has_many :card_formats
  has_many :cards, through: :card_formats
  has_many :decks
  validates :name, uniqueness: true
end
