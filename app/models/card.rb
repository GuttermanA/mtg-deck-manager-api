class Card < ApplicationRecord
  belongs_to :magic_set

  has_many :deck_cards
  has_many :decks, through: :deck_cards
  has_many :card_formats
  has_many :formats, through: :card_formats

  has_and_belongs_to_many :colors
  has_and_belongs_to_many :magic_sets
  has_and_belongs_to_many :supertypes
  has_and_belongs_to_many :types
  has_and_belongs_to_many :subtypes

  validates :name, uniqueness: true
  validates :img_url, presence: true
  # joins is inner join
  # includes is left join
  scope :colors, -> (colors) { joins(:colors).where('colors.name': colors).references(:colors) }
  scope :wildcard, -> (column, arg) { where("#{column} LIKE ?", "%#{arg}%")}

  def mainboard_deck_card_count(deck_id)
    self.deck_cards.find_by(deck_id: deck_id, sideboard: false).card_count
  end

  def self.search(params)
    if params["name"]
      Card.wildcard("name", params["name"])
    end
  end


end
