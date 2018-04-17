class ChangeTotalsColumnNamesForDecks < ActiveRecord::Migration[5.1]
  def change
    rename_column :decks, :mainboard, :total_mainboard
    rename_column :decks, :sideboard, :total_sideboard
  end
end
