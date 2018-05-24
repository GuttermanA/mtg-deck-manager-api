class DecksController < ApplicationController

  def search
    if params[:deck][:term]
      if params[:deck][:term] == 'default'
        @decks = Deck.default_search
      else
        @decks = Deck.basic_wildcard(params[:deck][:term])
      end
    end
    render json: DeckSerializer.new(@decks).serialized_json
  end

  def show
    @deck = Deck.by_id(params[:id])
    render json: DeckSerializer.new(@deck).serialized_json
  end

  def create
    byebug
    card_errors =  Card.validate_card_names(params[:cards])
    if card_errors.length > 0
      render json: {error: {message:"Some card names are incorrect", keys: card_errors}}
    else
      @deck = Deck.new(
        name: params[:name].titleize,
        archtype: params[:archtype],
        format_id: Format.find_by(name: params[:format]).id,
        user_id: decode_token["user_id"],
        tournament: params[:tournament],
        creator: params[:creator]
      )

      if @deck.save

        params[:cards].each do |card|
          new_deck_card = DeckCard.new(
            deck_id: @deck.id,
            card_id: Card.find_by(name: card[:info][:name]).id,
            card_count: card[:info][:count] == '' ?  1 : card[:info][:count],
            sideboard: card[:sideboard]
          )
          new_deck_card.save
        end
        @deck.save
        @deck = Deck.joins(:format, :user).where(id: @deck.id).select('decks.*, formats.name AS format_name, users.name AS user_name').references(:format, :user)[0]
        render json: DeckSerializer.new(@deck).serialized_json
      else
        render json: {message: "Failed to create deck", error: @deck.errors}
      end
    end
  end

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
      @deck = Deck.by_id(params[:id])
      @deck.card_count_calculator
      @deck.save
      render json: DeckSerializer.new(@deck).serialized_json
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    if @deck.destroy
      render json: {message: "#{@deck.name} deleted"}
    else
      render json: {message:"Something went wrong"}
    end
  end

end
