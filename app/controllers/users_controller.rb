class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to users_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all.pluck(:username, :id) ##Only the information we need
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end