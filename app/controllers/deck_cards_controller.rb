class DeckCardsController < ApplicationController
  def update
    if decode_token["user_id"]
      if params[:cardsToUpdate].length > 0
        params[:cardsToUpdate].each do |card|
          if card.has_key?("id")
            @deck_card = DeckCard.find_by(id: card[:id], sideboard: card[:sideboard], deck_id: params[:deck_id])
            @deck_card.update(card_count: card[:count])
          else
            @deck_card = DeckCard.new(deck_id: params[:deck_id], sideboard: card[:sideboard], card_count: card[:count] == nil ?  1 : card[:count], card_id: Card.find_by(name: card[:name]).id)
            @deck_card.save
          end
        end
      end

      if params[:cardsToDelete].length > 0
        ids_to_destroy = params[:cardsToDelete].map {|c| c[:id]}
        DeckCard.where(id: ids_to_destroy).destroy_all
      end
      @deck = Deck.find(params[:deck_id])
      @deck.card_count_calculator
      @deck.save
      render json: DeckSerializer.new(@deck).serialized_json
    end
  end

  def destroy

  end
end
