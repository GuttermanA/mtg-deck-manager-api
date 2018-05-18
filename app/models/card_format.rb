class CardFormat < ApplicationRecord
  belongs_to :card
  belongs_to :format
  before_create :unique_card_format

  def unique_card_format
    !!!CardFormat.find_by(
        card_id: self.card_id,
        format_id: self.format_id,
      )
  end
end
