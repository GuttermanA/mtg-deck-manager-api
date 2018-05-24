class DeckSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :id, :name, :creator, :archtype, :total_cards, :total_mainboard, :total_sideboard, :tournament, :created_at, :updated_at, :user_name, :user_id, :format_name
  # has_many :deck_cards
  # attribute :user do |object|
  #   {name: object.user.name, id: object.user.id}
  # end

  attribute :cards do |object|
    DeckCard.get_deck_cards_by_deck(object.id).as_json
  end

  # attribute :mainboard_cards do |object|
  #   DeckCardSerializer.new(DeckCard.get_deck_cards_by_deck_and_board( object.id, false)).serializable_hash
  #
  # end
  #
  # attribute :sideboard_cards do |object|
  #   DeckCardSerializer.new(DeckCard.get_deck_cards_by_deck_and_board(object.id, true)).serializable_hash
  # end

end
