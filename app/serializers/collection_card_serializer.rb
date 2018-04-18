class CollectionCardSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  cache_options enabled: true, cache_length: 12.hours
  attributes :id,:name,:mana_cost,:cmc,:full_type,:rarity,:text,:flavor,:artist,:number,:power,:toughness,:loyalty,:img_url,:multiverse_id,:layout,:count,:premium,:condition,:wishlist,:updated_at,:set_name,:set_code
end
