class CollectionsController < ApplicationController
  def create
    params[:cards].each do |card|
      collection_card = Collection.find_or_initialize_by(
        user_id: decode_token["user_id"],
        card_id: Card.find_by(name: card[:name]).id,
        magic_set_id: MagicSet.find_by(code: card[:set]).id,
        condition: card[:condition],
        premium: card[:premium],
        wishlist: card[:wishlist]
      )
          byebug
      collection_card.count = !collection_card.id ? card[:number] : collection_card.count + card[:number]
      collection_card.save
    end
    #
    # render json: Card.get_collection_cards_by_user(decode_token["user_id"])
    render json: CollectionSerializer.new(Collection.where(user_id: decode_token["user_id"]), include: [:card])
  end
end
