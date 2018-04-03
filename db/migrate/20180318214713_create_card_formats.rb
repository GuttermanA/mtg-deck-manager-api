class CreateCardFormats < ActiveRecord::Migration[5.1]
  def change
    create_table :card_formats do |t|
      t.belongs_to :card, index: true
      t.belongs_to :format, index: true
      t.boolean :legal, default: true
      t.timestamps
    end
  end
end
