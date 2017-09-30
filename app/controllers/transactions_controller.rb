class TransactionsController < ApplicationController

  before_filter :require_logged_in

  def create
    @transaction = Transaction.new(transaction_params)

    ##given_id MUST be defined in the backend so users cannot impersonate
    ##another id using postman or similar tools
    @transaction.given_id = current_user.id

    unless @transaction.save
      flash[:errors] = @transaction.errors.full_messages
    end
    @transaction.save

    redirect_to users_url
  end

  def index
    @transactions = Transaction.all
  end

  private

  def transaction_params
    params.require(:transaction).permit(:number_credits, :received_id)
  end

end
