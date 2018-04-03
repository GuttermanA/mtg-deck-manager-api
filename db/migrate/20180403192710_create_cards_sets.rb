class CreateCardsSets < ActiveRecord::Migration[5.1]
  def change
    create_table :cards_sets, id: false do |t|
      belongs_to :card, index: true
      belongs_to :set, index: true
    end
  end
end
