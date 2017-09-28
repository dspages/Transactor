class Api::V1::UsersController < ApplicationController

  def show
    @user = current_user
    render json: { email: @user.email, credits: @user.count_credits }
  end

end
