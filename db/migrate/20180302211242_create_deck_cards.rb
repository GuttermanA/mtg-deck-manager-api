class CreateDeckCards < ActiveRecord::Migration[5.1]
  def change
    create_table :deck_cards do |t|
      belongs_to :deck, index: true
      belongs_to :card, index: true
      t.integer :card_count
      t.boolean :sideboard, default: false
      t.timestamps
    end
  end
end
