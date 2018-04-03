# standard_cards = MTG::Card.where(gameFormat: 'standard').all
# # standard_cards.map {|card| puts "Type: #{card.type} Supertype: #{card.supertypes} Subtypes: #{card.subtypes}"}
# # puts standard_cards.last.type
# # puts standard_cards.last.supertypes
# # puts standard_cards.last.subtypes
# # puts standard_cards.last.legalities.map {|legality| "#{legality.format}: #{legality.legality}"}
#
# standard_cards.each do |card|
#   new_card = Card.new(
#     name: card.name,
#     cmc: card.cmc,
#     mana_cost: card.mana_cost,
#     color_identity: card.color_identity.try(:join),
#     base_type: card.type.split(" — ")[0].gsub("Legendary ", ""),
#     rarity: card.rarity,
#     power: card.power,
#     toughness: card.toughness,
#     text: card.text,
#     img_url: card.image_url,
#     game_format: 'standard'
#   )
#   new_card.save
# end
#
# standard_cards.sample.colors.each do |color|
#   puts color
# end


all_cards = MTG::Card.where(gameFormat: 'standard').all
all_sets = MTG::Set.all

all_sets.each do |set|
  new_set = Set.new(
    name: set.name,
    code: set.code,
    release_date: set.release_date,
    block: set.block
  )
  new_set.save
end

all_cards.each do |card|
  new_card = Card.new(
    name: card.name,
    mana_cost: card.mana_cost,
    cmc: card.cmc,
    full_type: card.type,
    rarity: card.rarity,
    text: card.text,
    flavor: card.flavor,
    artist: card.artist,
    collector_number: card.number,
    power: card.power,
    toughness: card.toughness,
    loyalty: card.loyalty,
    img_url: card.image_url,
    multiverse_id: card.multiverse_id,
    layout: card.layout
    set_id: Set.find_or_create_by(name: card.set_name).id
  )
  new_card.save
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

end
