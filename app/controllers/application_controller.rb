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

  def metadata_load
    @formats = Format.all
    @archtypes = Deck.distinct.pluck(:archtype)
    @sets = MagicSet.all
    render json: {formats: @formats, archtypes: @archtypes, sets: @sets}
  end

end
