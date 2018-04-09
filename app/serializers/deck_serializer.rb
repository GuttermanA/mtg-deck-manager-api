class DeckSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :id, :name, :creator, :archtype, :total_cards, :mainboard, :sideboard, :tournament, :created_at, :updated_at

  attribute :user do |object|
    {name: object.user.name, id: object.user.id}
  end

  attribute :format do |object|
    object.format.name
  end

  attribute :mainboard_cards do |object|
    mainboard = object.deck_cards.select{|dc| !dc.sideboard}
    mainboard.map do |deck_card|
      card = deck_card.card.attributes
      card[:count] = deck_card.card_count
      card
    end
  end

  attribute :sideboard_cards do |object|
    sideboard = object.deck_cards.select{|dc| dc.sideboard}
    sideboard.map do |deck_card|
      card = deck_card.card.attributes
      card[:count] = deck_card.card_count
      card
    end
  end

end
