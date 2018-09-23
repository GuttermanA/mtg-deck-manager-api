class MagicSet < ApplicationRecord
  has_many :cards
  has_and_belongs_to_many :cards
  validates :name, uniqueness: true, presence: true

  def self.check_for_new_sets
    new_set_names = MTG::Set.all.map{|s| s.name} - MagicSet.all.map{|s| s.name}
    new_set_names.length ? new_set_names : nil
    if new_set_names.length > 0
      new_set_names
    else
      nil
    end
    # if new_set_names.length > 0
    #   new_set_names.each do |set|
    #     new_cards = MTG::Card.where(setName: set).all
    #     new_cards.each do |card|
    #
    #     puts "Added cards from #{set}"
    #   end
    # else
    #   puts "No new sets found"
    # end
  end

  def self.add(sets)
    new_sets = []
    sets.each do |set|
      new_set = MagicSet.new(
        name: set.name,
        code: set.code,
        release_date: set.release_date,
        block: set.block
      )
      new_set.save
      new_sets << new_set
      puts "Set #{new_set.name} created"
    end

    new_sets
  end

  def self.add_sets_from_card_data(card_data)
    sets = []
    card_data.printings.each do |printing|
      set = MagicSet.find_by(code: printing)
      if set
        puts "#{set.name} found"
        sets.push(set)
      else
        set_data =  MTG::Set.find(printing)
        new_set = MagicSet.new(
          name: set_data.name,
          code: set_data.code,
          release_date: set_data.release_date,
          block: set_data.block
        )
        new_set.save
        puts "Set #{new_set.name} created"
        sets.push(new_set)
      end
    end
    sets
  end

end
