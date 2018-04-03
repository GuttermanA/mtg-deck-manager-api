class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card
  validates :card_count, :card_id, :deck_id, presence: true
end
