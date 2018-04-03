class CreateSupertypesTypesAndSubtypes < ActiveRecord::Migration[5.1]
  def change
    create_table :supertypes do |t|
      t.string :name
      t.timestamps
    end

    create_table :cards_supertypes, id: false do |t|
      t.belongs_to :card, index: true
      t.belongs_to :supertype, index: true
    end

    create_table :types do |t|
      t.string :name
      t.timestamps
    end

    create_table :cards_types, id: false do |t|
      t.belongs_to :card, index: true
      t.belongs_to :type, index: true
    end

    create_table :subtypes do |t|
      t.string :name
      t.timestamps
    end

    create_table :cards_subtypes, id: false do |t|
      t.belongs_to :card, index: true
      t.belongs_to :subtype, index: true
    end

  end
end
