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

Card.seed(all_cards)

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
