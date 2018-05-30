class CardsController < ApplicationController

  def search
    if params[:card][:term]
      if params[:card][:term] == 'default'
        @cards = Card.default_search
      else
        @cards = Card.search(params[:card])
      end
    else

    end

    render json: CardSerializer.new(@cards).serialized_json
  end

  private

  def card_params
    params.require(:card).permit(
      :name,
      :mana_cost,
      :cmc,
      :full_type,
      :rarity,
      :text,
      :number,
      :power,
      :toughness,
      :loyalty,
      :layout,
      :primary_type
    )
  end
end
