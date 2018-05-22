class ChangeMagicSetToLastPrintingOnCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :last_printing, :string
    remove_column :cards, :magic_set_id
  end
end
