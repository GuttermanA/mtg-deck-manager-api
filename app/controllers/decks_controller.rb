class DecksController < ApplicationController

  def create
    # ADD CREATOR AFTER AUTH

    @deck = Deck.new(
      name: params[:name],
      archtype: params[:archtype],
      format_id: Format.find_by(name:params[:format]),
      user_id: 1,
      tournament: false
    )

    if @deck.save
      params[:cards].each do |board, cards|
        sideboard = board == "sideboard"
        cards.each do |card|
          new_deck_card = DeckCard.new(
            deck_id: @deck.id,
            card_id: Card.find_by(name: card[:name]).id,
            card_count: card[:number],
            sideboard: sideboard
          )
          new_deck_card.save
        end
      end
    else
      render json: {error: "Failed to create deck"}
    end
    @deck.card_count_calculator
    @deck.save
    render json: DeckSerializer.new(@deck).serialized_json
  end

  def show
    @deck = Deck.find(params[:id])
    render json: DeckSerializer.new(@deck).serialized_json
  end

end
