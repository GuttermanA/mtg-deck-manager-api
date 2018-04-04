class CreateMagicSet < ActiveRecord::Migration[5.1]
  def change
    create_table :magic_sets do |t|
      t.string :name
      t.string :code
      t.date :release_date
      t.string :block
      t.timestamps
    end
  end
end
