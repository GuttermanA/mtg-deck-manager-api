#Seed file to add single card. Just set new card var below from mtg_sdk

new_card =

new_card = Card.new(
  name: card.names.length > 0 ? card.names.join(" // ") : card.name,
  mana_cost: card.mana_cost,
  cmc: card.cmc,
  full_type: card.type,
  rarity: card.rarity,
  text: card.text,
  flavor: card.flavor,
  artist: card.artist,
  number: card.number,
  power: card.power,
  toughness: card.toughness,
  loyalty: card.loyalty,
  img_url: card.image_url,
  multiverse_id: card.multiverse_id,
  layout: card.layout,
  magic_set_id: MagicSet.find_by(code: card.set).id
)
new_card.save

if card.supertypes
  card.supertypes.each do |supertype|
    new_card.supertypes.push(Supertype.find_or_create_by(name: supertype))
  end
end

if card.types
  card.types.each do |type|
    new_card.types.push(Type.find_or_create_by(name: type))
  end
end

if card.subtypes
  card.subtypes.each do |subtype|
    new_card.subtypes.push(Subtype.find_or_create_by(name: subtype))
  end
end

card.printings.each do |printing|
  new_card.magic_sets.push(MagicSet.find_by(code: printing))
end

card.legalities.each do |legality|
  legal = false
  if legality.legality == 'Legal'
    legal = true
  end
  CardFormat.create(card_id: new_card.id, format_id: Format.find_or_create_by(name: legality.format).id, legal: legal)
end

if card.colors
  card.colors.each do |color|
    new_card.colors.push(Color.find_or_create_by(name: color))
  end
end
