class DeckCardSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :id, :deck_id,:card_count,:sideboard,:card_id,:name, :mana_cost,:cmc, :full_type, :rarity, :text, :flavor, :artist, :number, :power, :toughness, :loyalty, :multiverse_id, :img_url
end
