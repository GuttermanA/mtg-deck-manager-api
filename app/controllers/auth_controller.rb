class AuthController < ApplicationController
  def create
    if @user = User.find_by(name: params[:username])
      if @user.authenticate(params[:password])
        jwt = issue_token({user_id: @user.id})
        render json: {user: UserSerializer.new(@user).serializable_hash, jwt: jwt}
      else
        render json: {error: {message: "Invalid password"}}
      end
    else
      render json: {error: {message: "Username not found"}}
    end
  end

  def show
    if current_user
      render json: current_user
    else
      render json: {error: {message: "Not logged in"}}
    end
  end
end
