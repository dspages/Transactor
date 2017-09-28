class SessionsController < ApplicationController

  def new
    @action_url = session_url
    @action_name = "Log In"
  end

  def create
    credentials = params[:user]
    @user = User.find_by_credentials(
    credentials[:email],
    credentials[:password])
    if @user
      log_in(@user)
      redirect_to users_url
    else
      flash[:errors] = "No user matching those credentials"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end

end
