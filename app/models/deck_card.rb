class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card
  validates :card_id, :deck_id, presence: true
  before_create :unique_deck_card

  def unique_deck_card
    !!!DeckCard.find_by(card_id: self.card_id, deck_id: self.deck_id, sideboard: self.sideboard)
  end



  def self.get_deck_cards_by_deck(deck_id)
    DeckCard.select(
      'deck_cards.id',
      'deck_cards.card_count AS count',
      'deck_cards.sideboard',
      'deck_cards.card_id',
      'cards.name',
      'cards.mana_cost',
      'cards.cmc',
      'cards.full_type',
      'cards.rarity',
      'cards.text',
      'cards.flavor',
      'cards.artist',
      'cards.number',
      'cards.power',
      'cards.toughness',
      'cards.loyalty',
      'cards.multiverse_id',
      'cards.img_url',
      'cards.primary_type'
    ).joins(:card).where(deck_id: deck_id).references(:card)
  end



end
