class Collection < ApplicationRecord
  belongs_to :user
  belongs_to :card
  belongs_to :magic_set
  validates :user_id, uniqueness: true
  validate :unique_collection_card

  def unique_collection_card
    !!!Collection.find_by(
        card_id: self.card_id,
        user_id: self.user_id,
        magic_set_id: self.sideboard,
        premium: self.premium,
        wishlist: self.wishlist,
        condition: self.condition
      )
  end


end
