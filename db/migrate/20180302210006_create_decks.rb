class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    enable_extension :citext
    create_table :decks do |t|
      t.citext :name
      t.string :creator
      t.citext :archtype, index: true
      t.belongs_to :format, index: true
      t.belongs_to :user, index: true
      t.integer :total_cards
      t.integer :mainboard
      t.string :sideboard
      t.boolean :tournament, default: false
      t.timestamps
    end
  end
end
