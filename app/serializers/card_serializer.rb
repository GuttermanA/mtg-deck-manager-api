class CardSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :mana_cost, :cmc, :full_type, :rarity, :text, :flavor, :artist, :number, :power, :toughness, :multiverse_id, :img_url

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

end
