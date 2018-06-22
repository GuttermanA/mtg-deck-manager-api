class MagicSet < ApplicationRecord
  has_many :cards
  has_and_belongs_to_many :cards
  validates :name, uniqueness: true

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
end
