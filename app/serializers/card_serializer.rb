class CardSerializer < ActiveModel::Serializer
  attributes :name, :mana_cost, :cmc, :full_type, :rarity, :text, :flavor, :artist, :number, :power, :toughness, :loyalty, :img_url, :layout, :multiverse_id, :printings, :latest_set, :colors, :formats, :supertypes, :subtypes, :types

  def printings
    object.magic_sets
  end

  def latest_set
    object.magic_set
  end

  def colors
    object.colors
  end

  def formats
    object.formats
  end

  def supertypes
    object.supertypes
  end

  def types
    object.types
  end

  def subtypes
    object.subtypes
  end
end
