class CreateCardsMagicSets < ActiveRecord::Migration[5.1]
  def change
    create_table :cards_magic_sets, id: false do |t|
      t.belongs_to :card, index: true
      t.belongs_to :magic_set, index: true
    end
  end
end
