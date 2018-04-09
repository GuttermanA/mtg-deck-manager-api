class UsersController < ApplicationController
  def create
    @user = User.new(name: params[:username], password: params[:password])
    if @user.save
      jwt = issue_token({user_id: @user.id})
      render json: {user: UserSerializer.new(@user).serializable_hash, jwt: jwt}
    end
  end
end
