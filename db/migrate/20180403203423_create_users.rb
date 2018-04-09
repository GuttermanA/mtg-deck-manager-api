class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    enable_extension :citext
    create_table :users do |t|
      t.citext :name, index: true
      t.string :password_digest
      t.timestamps
    end
  end
end
