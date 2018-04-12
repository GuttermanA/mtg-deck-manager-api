class AddDefaultToCardCountInDeckCards < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:deck_cards, :card_count, 1)
  end
end
