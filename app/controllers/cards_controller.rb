class CardsController < ApplicationController

  def search
    if params[:card][:term]
      if params[:card][:term] == ''
        # most_recent_set = MagicSet.order(release_date: :desc).limit(1)[0].id
        @cards = Card.default_search
        # @cards = Card.order('magic_set.release_date').joins(:magic_set).references(:magic_set)
      else
        # @cards = Card.search(params[:card])
      end
      # @cards = MagicSet.order(release_date: :desc).limit(1)[0].cards
    else

    end

    render json: CardSerializer.new(@cards).serialized_json
  end

  def index

  end

  def show
    Card.joins(:supertypes, :subtypes, :types).select('types.*').where("cards.name LIKE ?", "%angel%")
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
