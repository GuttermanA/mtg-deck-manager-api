class DecksController < ApplicationController

  def search
    @decks = Deck.basic_search(params[:deck][:term])
    render json: DeckSerializer.new(@decks).serialized_json
  end

  def show
    @deck = Deck.find(params[:id])
    render json: DeckSerializer.new(@deck).serialized_json
  end

  def create
    card_errors =  {mainboard:  Card.validate_card_names(params[:cards][:mainboard])}
    sideboard_errors = Card.validate_card_names(params[:cards][:sideboard])
    sideboard_errors ? card_errors[:sideboard] = sideboard_errors : nil
    if card_errors.values.flatten.length > 0
      render json: {error: {message:"Some card names are incorrect", keys: card_errors}}
    else
      @deck = Deck.new(
        name: params[:name],
        archtype: params[:archtype],
        format_id: Format.find_by(name: params[:format]).id,
        user_id: decode_token["user_id"],
        tournament: params[:tournament]
      )

      if @deck.save

        params[:cards].each do |board, cards|
          sideboard = board == "sideboard"
          cards.each do |card|
            if card[:name].length > 0
              new_deck_card = DeckCard.new(
                deck_id: @deck.id,
                card_id: Card.find_by(name: card[:name]).id,
                card_count: card[:count] == nil ?  1 : card[:count],
                sideboard: sideboard
              )
              new_deck_card.save
            end
          end
        end
      else
        render json: {error: "Failed to create deck"}
      end
      @deck.save

      render json: DeckSerializer.new(@deck).serialized_json
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    if @deck.destroy
      render json: {message: "#{@deck.name} deleted"}
    else
      render json: {error: {message:"Something went wrong"}}
    end
  end

end
