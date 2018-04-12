class CollectionsController < ApplicationController
  def create
    byebug
    params[:cards].each do |card|
      collection_card = Collection.find_or_initialize_by(
        user_id: decode_token["user_id"],
        card_id: Card.find_by(name: card[:name],
        magic_set_id: MagicSet.find_by(code: card[:set]),
        condition: card[:condition],
        premium: card[:premium],
        wishlist: card[:wishlist]
      )
      collection_card.count = card[:number]
      collection_card.save
    end

    render json: Card.get_collection_cards_by_user(params[:user])
  end
end
