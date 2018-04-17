class AddPrimaryTypeToCards < ActiveRecord::Migration[5.1]
  def change
    add_column(:cards, :primary_type, :string)
  end
end
