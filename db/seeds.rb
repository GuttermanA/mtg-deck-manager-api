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

avacyn = {
      "name":"Archangel Avacyn",
      "names":[
          "Archangel Avacyn",
          "Avacyn, the Purifier"
      ],
      "manaCost":"{3}{W}{W}",
      "cmc":5,
      "colors":[
          "White"
      ],
      "colorIdentity":[
          "W"
      ],
      "type":"Legendary Creature — Angel",
      "supertypes":[
          "Legendary"
      ],
      "types":[
          "Creature"
      ],
      "subtypes":[
          "Angel"
      ],
      "rarity":"Mythic Rare",
      "set":"SOI",
      "text":"Flash\nFlying, vigilance\nWhen Archangel Avacyn enters the battlefield, creatures you control gain indestructible until end of turn.\nWhen a non-Angel creature you control dies, transform Archangel Avacyn at the beginning of the next upkeep.",
      "artist":"James Ryman",
      "number":"5a",
      "power":"4",
      "toughness":"4",
      "layout":"double-faced",
      "multiverseid":409741,
      "imageUrl":"http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=409741&type=card",
      "rulings":[
          {
          "date":"2016-04-08",
          "text":"Archangel Avacyn’s delayed triggered ability triggers at the beginning of the next upkeep regardless of whose turn it is."
          },
          {
          "date":"2016-04-08",
          "text":"Archangel Avacyn’s delayed triggered ability won’t cause it to transform back into Archangel Avacyn if it has already transformed into Avacyn, the Purifier, perhaps because several creatures died in one turn."
          },
          {
          "date":"2016-04-08",
          "text":"For more information on double-faced cards, see the Shadows over Innistrad mechanics article (http://magic.wizards.com/en/articles/archive/feature/shadows-over-innistrad-mechanics)."
          }
      ],
      "foreignNames":[
          {
          "name":"大天使艾维欣",
          "language":"Chinese Simplified",
          "multiverseid":410071
          },
          {
          "name":"大天使艾維欣",
          "language":"Chinese Traditional",
          "multiverseid":410401
          },
          {
          "name":"Archange Avacyn",
          "language":"French",
          "multiverseid":411061
          },
          {
          "name":"Erzengel Avacyn",
          "language":"German",
          "multiverseid":410731
          },
          {
          "name":"Arcangelo Avacyn",
          "language":"Italian",
          "multiverseid":411391
          },
          {
          "name":"大天使アヴァシン",
          "language":"Japanese",
          "multiverseid":411721
          },
          {
          "name":"대천사 아바신",
          "language":"Korean",
          "multiverseid":412051
          },
          {
          "name":"Arcanjo Avacyn",
          "language":"Portuguese (Brazil)",
          "multiverseid":412381
          },
          {
          "name":"Архангел Авацина",
          "language":"Russian",
          "multiverseid":412711
          },
          {
          "name":"Arcángel Avacyn",
          "language":"Spanish",
          "multiverseid":413041
          }
      ],
      "printings":[
          "SOI"
      ],
      "originalText":"Flash\nFlying, vigilance\nWhen Archangel Avacyn enters the battlefield, creatures you control gain indestructible until end of turn.\nWhen a non-Angel creature you control dies, transform Archangel Avacyn at the beginning of the next upkeep.",
      "originalType":"Legendary Creature — Angel",
      "id":"02ea5ddc89d7847abc77a0fbcbf2bc74e6456559"
    }


all_cards = MTG::Card.all
all_sets = MTG::Set.all
# card = MTG::Card.find(409741)


all_sets.each do |set|
  new_set = MagicSet.new(
    name: set.name,
    code: set.code,
    release_date: set.release_date,
    block: set.block
  )
  new_set.save
end

Format.find_or_create_by(name: "Casual")
#
# new_card = Card.new(
#   name: card.names.length > 0 ? card.names.join(" // ") : card.name,
#   mana_cost: card.mana_cost,
#   cmc: card.cmc,
#   full_type: card.type,
#   rarity: card.rarity,
#   text: card.text,
#   flavor: card.flavor,
#   artist: card.artist,
#   number: card.number,
#   power: card.power,
#   toughness: card.toughness,
#   loyalty: card.loyalty,
#   img_url: card.image_url,
#   multiverse_id: card.multiverse_id,
#   layout: card.layout,
#   magic_set_id: MagicSet.find_by(code: card.set).id
# )
# new_card.save
#
# if card.supertypes
#   card.supertypes.each do |supertype|
#     new_card.supertypes.push(Supertype.find_or_create_by(name: supertype))
#   end
# end
#
# if card.types
#   card.types.each do |type|
#     new_card.types.push(Type.find_or_create_by(name: type))
#   end
# end
#
# if card.subtypes
#   card.subtypes.each do |subtype|
#     new_card.subtypes.push(Subtype.find_or_create_by(name: subtype))
#   end
# end
#
# card.printings.each do |printing|
#   new_card.magic_sets.push(MagicSet.find_by(code: printing))
# end
#
# card.legalities.each do |legality|
#   legal = false
#   if legality.legality == 'Legal'
#     legal = true
#   end
#   CardFormat.create(card_id: new_card.id, format_id: Format.find_or_create_by(name: legality.format).id, legal: legal)
# end
#
# if card.colors
#   card.colors.each do |color|
#     new_card.colors.push(Color.find_or_create_by(name: color))
#   end
# end



all_cards.each do |card|
  new_card = Card.new(
    name: card.names && card.names.length > 0 ? card.names.join(" // ") : card.name,
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
  if new_card.save
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

    if card.legalities
      card.legalities.each do |legality|
        legal = false
        if legality.legality == 'Legal'
          legal = true
        end
        CardFormat.create(card_id: new_card.id, format_id: Format.find_or_create_by(name: legality.format).id, legal: legal)
      end
    end



    if card.colors
      card.colors.each do |color|
        new_card.colors.push(Color.find_or_create_by(name: color))
      end
    end
  end
end
