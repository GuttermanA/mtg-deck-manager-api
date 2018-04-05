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

    @deck.save

    params[:cards].each do |board, cards|
      cards.each do |card|
        sideboard = board == "sideboard"
        new_deck_card = DeckCard.new(
          deck_id: @deck.id,
          card_id: Card.find_by(name: card[:name]).id,
          card_count: card[:number],
          sideboard: sideboard
        )
        new_deck_card.save
      end
    end


    @deck.mainboard = DeckCard.where(deck_id: @deck.id, sideboard: false).sum(:card_count)
    @deck.sideboard = DeckCard.where(deck_id: @deck.id, sideboard: true).sum(:card_count)
    @deck.total_cards = @deck.mainboard + @deck.sideboard
    @deck.save
    render json: @deck
  end

end
