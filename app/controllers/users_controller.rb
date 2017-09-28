class UsersController < ApplicationController

  def new
    @action_url = users_url
    @action_name = "Sign Up"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to users_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def index
    @users = User.all.pluck(:email, :id) ##Only the information we need
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
