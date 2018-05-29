class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card
  validates :card_id, :deck_id, presence: true
  before_create :unique_deck_card

  def unique_deck_card
    !!!DeckCard.find_by(card_id: self.card_id, deck_id: self.deck_id, sideboard: self.sideboard)
  end



  def self.get_deck_cards_by_deck(deck_id)
    # OLD VERSION
    # sql = <<-SQL
    #   SELECT
    #     deck_cards.id,
    #     deck_cards.deck_id,
    #     deck_cards.card_count,
    #     deck_cards.sideboard,
    #     deck_cards.card_id,
    #     cards.name,
    #     cards.mana_cost,
    #     cards.cmc,
    #     cards.full_type,
    #     cards.rarity,
    #     cards.text,
    #     cards.flavor,
    #     cards.artist,
    #     cards.number,
    #     cards.power,
    #     cards.toughness,
    #     cards.loyalty,
    #     cards.multiverse_id,
    #     cards.img_url
    #   FROM deck_cards
    #   INNER JOIN cards ON
    #   deck_cards.card_id = cards.id
    #   WHERE
    #   deck_cards.deck_id = ?
    #   AND
    #   deck_cards.sideboard = ?
    #   SQL
    #   DeckCard.find_by_sql [sql, deck_id, sideboard]
    # deck_cards = DeckCard.select(
    #   'deck_cards.id',
    #   # 'deck_cards.deck_id',
    #   'deck_cards.card_count AS count',
    #   'deck_cards.sideboard',
    #   'deck_cards.card_id',
    #   'cards.name',
    #   'cards.mana_cost',
    #   'cards.cmc',
    #   'cards.full_type',
    #   'cards.rarity',
    #   'cards.text',
    #   'cards.flavor',
    #   'cards.artist',
    #   'cards.number',
    #   'cards.power',
    #   'cards.toughness',
    #   'cards.loyalty',
    #   'cards.multiverse_id',
    #   'cards.img_url',
    #   'cards.primary_type'
    # ).joins(:card).where(deck_id: deck_id).references(:card, :types)
    #
    # cards = {mainboard:{}, sideboard:[]}
    #
    # deck_cards.each do |c|
    #   card_hash = c.attributes
    #   if card_hash["sideboard"]
    #     cards[:sideboard] << card_hash
    #   else
    #     card_type = card_hash["primary_type"].downcase.pluralize
    #     if cards[:mainboard].has_key?(card_type)
    #       cards[:mainboard][card_type] << card_hash
    #     else
    #       cards[:mainboard][card_type] = [card_hash]
    #     end
    #   end
    # end
    # cards

    # NEW VERSION
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
