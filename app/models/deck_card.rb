class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card
  validates :card_count, :card_id, :deck_id, presence: true
  validate :unique_deck_card

  def unique_deck_card
    !!!DeckCard.find_by(card_id: self.card_id, deck_id: self.deck_id, sideboard: self.sideboard)
  end
end
