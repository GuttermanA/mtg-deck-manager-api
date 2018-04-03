class CreateCardsSets < ActiveRecord::Migration[5.1]
  def change
    create_table :cards_sets, id: false do |t|
      t.belongs_to :card, index: true
      t.belongs_to :set, index: true
    end
  end
end
