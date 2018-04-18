class CollectionsController < ApplicationController
  def create
    params[:cards].each do |card|
      if card[:name].length > 0
        collection_card = Collection.find_or_initialize_by(
          user_id: decode_token["user_id"],
          card_id: Card.find_by(name: card[:name]).id,
          magic_set_id: MagicSet.find_by(code: card[:set]).id,
          condition: card[:condition],
          premium: card[:premium],
          wishlist: card[:wishlist]
        )
        collection_card.count = !collection_card.id ? card[:number] : collection_card.count + card[:number]
        byebug
        collection_card.save
      end
    end
    render json: CollectionCardSerializer.new(Card.get_collection_cards_by_user(decode_token["user_id"])).serializable_hash
  end

  def update
    @collection_card = Collection.find_by(id: params[:id], user_id: decode_token["user_id"])
    if @collection_card
      @collection_card.update(magic_set_id: MagicSet.find_by(code: params[:setCode]).id, condition: params[:condition], wishlist: params[:wishlist], premium: params[:premium], count: params[:count])
      render json: CollectionCardSerializer.new(Card.get_collection_cards_by_user(decode_token["user_id"])).serializable_hash
    end
  end

  def destroy
    @collection_card = Collection.find_by(id: params[:id], user_id: decode_token["user_id"])
    if @collection_card
      @collection_card.destroy
      render json: CollectionCardSerializer.new(Card.get_collection_cards_by_user(decode_token["user_id"])).serializable_hash
    end
  end
end
