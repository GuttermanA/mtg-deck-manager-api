class CardsController < ApplicationController

  def search
    @cards = Card.search(params[:card])
    render json: CardSerializer.new(@cards).serialized_json
  end

  def index

  end

  def show

  end

  # private
  #
  # def card_params
  #   params.require(:card).permit(:name, :cmc, :mana_cost, :color_identity, :base_type, :rarity, :power, :toughness)
  # end
end
