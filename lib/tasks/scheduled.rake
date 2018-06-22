namespace :update do
  desc "Checks if current Magic Sets match the https://api.magicthegathering.io sets. If not, seed cards from missing set."
  task :seed_new_set => :environment do
    puts "Checking for new set(s)"
    new_sets = MagicSet.check_for_new_sets
    if new_sets
      new_sets_list = new_sets.join(',')
      puts "Found #{new_sets_list} set(s)"
      new_cards_dataset = MTG::Card.where(setName: new_sets_list).all
        count = Card.seed(new_cards_dataset)
        puts "Added cards from #{new_sets_list}"
        puts "Added #{count} cards"
      # new_sets.each do |set|
      #   new_cards_dataset = MTG::Card.where(setName: set).all
      #   count = Card.seed(new_cards_dataset)
      #   puts "Added #{count} cards from #{set}"
      # end
    else
      puts "No new sets at this time"
    end

  end
end
