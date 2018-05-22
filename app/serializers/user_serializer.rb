class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :id, :name
  # cache_options enabled: true, cache_length: 12.hours
  # has_many :decks
  # has_many :collections

  attribute :decks do |object|
    DeckSerializer.new(Deck.joins(:format, :user).where(user_id: object.id).select('decks.*, formats.name AS format_name, users.name AS user_name').references(:format, :user)).serializable_hash
  end

  attribute :collection do |object|
    CollectionCardSerializer.new(Card.get_collection_cards_by_user(object.id)).serializable_hash
    # CollectionSerializer.new(Collection.all, include: [:card]).serializable_hash
  end
end
