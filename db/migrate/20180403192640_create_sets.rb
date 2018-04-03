class CreateSets < ActiveRecord::Migration[5.1]
  def change
    create_table :sets do |t|
      t.string :name
      t.string :code
      t.date :release_date
      t.string :block
      t.timestamps
    end
  end
end
