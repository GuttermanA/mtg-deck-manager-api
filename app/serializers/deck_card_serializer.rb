class DeckCardSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  # cache_options enabled: true, cache_length: 12.hours
  attributes :id, :deck_id,:card_count,:sideboard,:card_id,:name, :mana_cost,:cmc, :full_type, :rarity, :text, :flavor, :artist, :number, :power, :toughness, :loyalty, :multiverse_id, :img_url, :primary_type
  # attributes :card_count, :sideboard
  #
  # belongs_to :card
end
