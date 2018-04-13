class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :id, :name

  attribute :decks do |object|
    DeckSerializer.new(object.decks).serializable_hash
  end

  attribute :collection do |object|
    CollectionCardSerializer.new(Card.get_collection_cards_by_user(object.id)).serializable_hash
  end
end
