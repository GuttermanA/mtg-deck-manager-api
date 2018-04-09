class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :id, :name

  attribute :decks do |object|
    DeckSerializer.new(object.decks).serializable_hash
  end

  attribute :collection do |object|
    object.collection
  end
end
