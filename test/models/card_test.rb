require 'test_helper'

class CardTest < ActiveSupport::TestCase

  # test "should not save with a duplicate name" do
  #   card = Card.new
  #   card.name = "Forest"
  #   card.img_url = '#'
  #   assert_not card.save, "Saved card with same name as existing card"
  # end

  test "Card.seed should take an array of card objects and add them to the database" do
    number_of_cards_to_add = 2
    seeded_cards = Card.all.size
    card_data = MTG::Card.where(page: 50).where(pageSize: number_of_cards_to_add).all
    Card.seed(card_data)
    assert Card.all.size == number_of_cards_to_add + seeded_cards , "Only #{Card.all.size - 2} cards added to the database"
  end

  test "primary_type should always be creature if the card's type line includes creature" do
    number_of_cards_to_add = 1
    seeded_cards = Card.all.size
    card_data = MTG::Card.where(types:'creature,artifact', page: 1, pageSize: number_of_cards_to_add).all
    Card.seed(card_data)
    assert Card.last.primary_type == "Creature", "Card with types of creature and x showing primary type != Creature"
  end


end
