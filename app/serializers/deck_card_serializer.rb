class DeckCardSerializer
  include FastJsonapi::ObjectSerializer
  set_type :deck_card
  set_id :card_id
  set_key_transform :camel_lower
  attributes :card_count, :sideboard
  belongs_to :card, record_type: :card
  belongs_to :deck, record_type: :deck
end
