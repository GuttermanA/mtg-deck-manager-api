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
    DeckCardSerializer.new(DeckCard.get_deck_cards_by_deck_and_board( object.id, false)).serializable_hash
  end

  attribute :sideboard_cards do |object|
    DeckCardSerializer.new(DeckCard.get_deck_cards_by_deck_and_board(object.id, true)).serializable_hash
  end

end
