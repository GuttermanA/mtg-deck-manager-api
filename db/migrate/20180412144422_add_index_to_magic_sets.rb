class AddIndexToMagicSets < ActiveRecord::Migration[5.1]
  def change
    add_index(:magic_sets, :code)
  end
end
