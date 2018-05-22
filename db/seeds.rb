User.create(name: "admin", password: "1234", admin: true)

all_cards = MTG::Card.all
puts "Fetching all cards..."
all_sets = MTG::Set.all
puts "Fetch all sets..."
formats = ['Standard', 'Modern', 'Legacy', 'Vintage', 'Commander']
# all_cards = MTG::Card.where(name: 'Dominaria').all

all_sets.each do |set|
  new_set = MagicSet.new(
    name: set.name,
    code: set.code,
    release_date: set.release_date,
    block: set.block
  )
  new_set.save
  puts "Set #{new_set.name} created"
end

Format.find_or_create_by(name: "Casual")
puts "Created custom format: Casual"

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
    last_printing: card.set
  )
  if new_card.save
    puts "Created card: #{new_card.name}"
    if card.supertypes
      card.supertypes.each do |supertype|
        new_card.supertypes.push(Supertype.find_or_create_by(name: supertype))
      end
    end

    if card.types
      card.types.each do |type|
        new_card.types.push(Type.find_or_create_by(name: type))
      end
      new_card_types = new_card.types.map { |t| t.name }
      if new_card_types.include?("Creature")
        new_card.primary_type = "Creature"
      else
        new_card.primary_type = new_card_types.first
      end
      new_card.save

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
      # CardFormat.create(card_id: new_card.id, format_id: Format.find_or_create_by(name: "Standard").id, legal: true)
      CardFormat.create(card_id: new_card.id, format_id: Format.find_or_create_by(name: "Casual").id, legal: true)
      card.legalities.each do |legality|
        if formats.include?(legality.format)
          legal = false
          if legality.legality == 'Legal'
            legal = true
          end
          CardFormat.find_or_create_by(card_id: new_card.id, format_id: Format.find_or_create_by(name: legality.format).id, legal: legal)
        end
      end
    end

    if card.colors
      card.colors.each do |color|
        new_card.colors.push(Color.find_or_create_by(name: color))
      end
    end

  else
    puts "Failed to create #{new_card.name}. Errors: #{new_card.errors.full_messages}"
  end
end

# Update Dominaria legalities
Card.where(last_printing: "DOM").each do |c|
  formats.each do |format|
    CardFormat.find_or_create_by(card_id: c.id, format_id: Format.find_or_create_by(name: format).id, legal: true)
  end
end
puts "Added missing legalities to Dominaria cards"

puts "Success!"
puts "Cards created: #{Card.all.size}"
puts "Supertypes created: #{Supertype.all.size}"
puts "Types created: #{Type.all.size}"
puts "Subtypes created: #{Subtype.all.size}"
puts "Sets created: #{MagicSet.all.size}"
puts "Formats created: #{Format.all.size}"

puts "Scraping decks from front page of mtgtop8.com"

Deck.mtgtop8_scrape_homepage_decks

puts "Done! #{Deck.all.size} decks added to database."
