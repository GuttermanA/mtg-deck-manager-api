class CreateCardsColors < ActiveRecord::Migration[5.1]
  def change
    create_table :cards_colors, id: false do |t|
      belongs_to :card, index: true
      belongs_to :color, index: true
    end
  end
end
