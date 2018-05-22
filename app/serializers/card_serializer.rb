class CardSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  cache_options enabled: true, cache_length: 12.hours
  attributes :id, :name, :mana_cost, :cmc, :full_type, :rarity, :text, :flavor, :artist, :number, :power, :toughness, :multiverse_id, :img_url, :primary_type,:last_printing

  # attribute :types do |object|
  #   object.types.map {|t| t.name}
  # end
  #
  # attribute :supertypes do |object|
  #   object.supertypes.map {|t| t.name}
  # end
  #
  # attribute :subtypes do |object|
  #   object.subtypes.map {|t| t.name}
  # end

  # attribute :set_code do |object|
  #   object.magic_set.code
  # end

end
