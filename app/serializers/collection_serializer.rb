class CollectionSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :id, :count, :premium, :condition, :updated_at

  attribute :magic_set do |object|
    object.magic_set.name
  end

  belongs_to :card

end
