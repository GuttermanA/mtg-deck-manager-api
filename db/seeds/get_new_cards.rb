new_set_names = MTG::Set.all.map{|s| s.name} - MagicSet.all.map{|s| s.name}

new_set_names.each do |set|
  MTG::Card.where(setName: set).all.
  puts "Added cards from #{set}"
end
