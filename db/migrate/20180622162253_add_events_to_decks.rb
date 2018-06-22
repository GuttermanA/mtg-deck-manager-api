class AddEventsToDecks < ActiveRecord::Migration[5.1]
  def change
    add_column :decks, :event_id, :integer
  end
end
