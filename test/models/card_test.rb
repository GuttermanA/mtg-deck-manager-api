require 'test_helper'

class CardTest < ActiveSupport::TestCase

  setup do
    @number_of_cards_to_add = 2
    @seeded_cards = Card.all.size
  end

  test "Card.seed should take an array of card objects and add them to the database" do
    card_data = MTG::Card.where(page: 50).where(pageSize: @number_of_cards_to_add).all
    Card.seed(card_data)
    assert Card.all.size == @number_of_cards_to_add + @seeded_cards , "Only #{Card.all.size - 2} cards added to the database"
  end

  test "primary_type should always be creature if the card's type line includes creature" do
    card_data = MTG::Card.where(types:'creature,artifact', page: 1, pageSize: @number_of_cards_to_add).all
    Card.seed(card_data)
    assert Card.last.primary_type == "Creature", "Card with types of creature and x showing primary type != Creature"
  end

  test "Card.basic_wildcard(arg) should return cards based on name and type" do
    type_term = "zombie"
    name_term = "ghoul"
    type_results = Card.basic_wildcard(type_term)
    name_results = Card.basic_wildcard(name_term)
    assert type_results.size == 2, "Only #{type_results.size} cards found by #{type_term} search term"
    assert name_results.size == 1, "Only #{name_results.size} cards found by #{name_term} search term"
  end

end
