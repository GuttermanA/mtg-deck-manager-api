class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card
  validates :card_id, :deck_id, presence: true
  before_create :unique_deck_card

  def unique_deck_card
    !!!DeckCard.find_by(card_id: self.card_id, deck_id: self.deck_id, sideboard: self.sideboard)
  end

  def self.get_deck_cards_by_deck_and_board(deck_id, sideboard)
    sql = <<-SQL
      SELECT
        deck_cards.id,
        deck_cards.deck_id,
        deck_cards.card_count,
        deck_cards.sideboard,
        deck_cards.card_id,
        cards.name,
        cards.mana_cost,
        cards.cmc,
        cards.full_type,
        cards.rarity,
        cards.text,
        cards.flavor,
        cards.artist,
        cards.number,
        cards.power,
        cards.toughness,
        cards.loyalty,
        cards.multiverse_id,
        cards.img_url
      FROM deck_cards
      INNER JOIN cards ON
      deck_cards.card_id = cards.id
      WHERE
      deck_cards.deck_id = ?
      AND
      deck_cards.sideboard = ?
      SQL
      DeckCard.find_by_sql [sql, deck_id, sideboard]
  end



end
