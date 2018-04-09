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
    UserSerializer.new(user).serialized_json
  end

  def get_token
    request.headers["Authorization"]
  end

end
