class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    enable_extension :citext
    create_table :events do |t|
      t.citext :name, index: true
      t.date :date
      t.belongs_to :format
      t.integer :players
      t.string :external_link
      t.timestamps
    end
  end
end
