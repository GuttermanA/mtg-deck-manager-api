class CreateCards < ActiveRecord::Migration[5.1]
  # ORIGINAL CREATE FOR standard_cards
  # def change
  #   create_table :cards do |t|
  #     t.string :name
  #     t.integer :cmc
  #     t.string :mana_cost
  #     t.string :color_identity
  #     t.string :base_type
  #     t.string :rarity
  #     t.integer :power
  #     t.integer :toughness
  #     t.string :text
  #     t.string :img_url
  #     t.string :game_format
  #     t.timestamps
  #   end
  # end
  def change
    create_table :cards do |t|
      t.string :name, index: true
      t.string :mana_cost
      t.integer :cmc
      t.string :full_type
      t.string :rarity
      t.string :text
      t.string :flavor
      t.string :artist
      t.string :number
      t.string :power
      t.string :toughness
      t.integer :loyalty
      t.string :img_url
      t.integer :multiverse_id
      t.string :layout
      t.belongs_to :magic_set, index: true
    end
  end
end
