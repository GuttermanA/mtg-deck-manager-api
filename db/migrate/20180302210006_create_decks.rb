class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|
      t.string :name
      t.belongs_to :format, index: true
      t.integer :card_count
      t.boolean :tournament, default: false
      t.timestamps
    end
  end
end
