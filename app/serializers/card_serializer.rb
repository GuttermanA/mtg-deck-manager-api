class CardSerializer < ActiveModel::Serializer
  attributes :name, :mana_cost, :cmc, :full_type, :rarity, :text, :flavor, :artist, :collector_number, :power, :toughness, :loyalty, :img_url, :set_id
end
