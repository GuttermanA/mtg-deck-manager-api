class Deck < ApplicationRecord
  belongs_to :user
  belongs_to :format
  has_many :deck_cards, dependent: :delete_all
  has_many :cards, through: :deck_cards

  validates :name, :format, presence: true

  scope :basic_search, -> (term) { where("name LIKE ? OR archtype LIKE ?", "%#{term}%", "%#{term}%")}


  def card_count_calculator
    self.total_mainboard = DeckCard.where(deck_id: self.id, sideboard: false).sum(:card_count)
    self.total_sideboard = DeckCard.where(deck_id: self.id, sideboard: true).sum(:card_count)
    self.total_cards = self.total_mainboard + self.total_sideboard
  end
end
