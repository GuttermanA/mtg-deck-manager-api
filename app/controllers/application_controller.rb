class ApplicationController < ActionController::API

  def issue_token(payload)
    JWT.encode(payload, ENV["jwt_secret"])
  end

  def decode_token
    JWT.decode(get_token, ENV["jwt_secret"])[0]
  end

  def current_user
    decoded_hash = decode_token
    user = User.find(decoded_hash["user_id"])
    UserSerializer.new(user).serializable_hash
  end

  def get_token
    request.headers["Authorization"]
  end

  def cache_card_of_the_day
    Rails.cache.fetch("card_of_the_day", expires_in: 24.hours) do
      Card.order("RANDOM()").first
    end
  end

  def cache_deck_of_the_day
    Rails.cache.fetch("deck_of_the_day", expires_in: 24.hours) do
      DeckSerializer.new(Deck.order("RANDOM()").first)
    end
  end

  def metadata_load
    @formats = Format.all
    @archtypes = Deck.distinct.pluck(:archtype)
    @sets = MagicSet.all

    card_of_the_day = cache_card_of_the_day

    deck_of_the_day = cache_deck_of_the_day

    render json: {formats: @formats, archtypes: @archtypes, sets: @sets, card_of_the_day: CardSerializer.new(card_of_the_day), deck_of_the_day: DeckSerializer.new(deck_of_the_day)}
  end

end
