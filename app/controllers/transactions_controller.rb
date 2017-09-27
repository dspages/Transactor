class TransactionsController < ApplicationController

  before_filter :require_logged_in

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.given_id = current_user.id
    if @transaction.save
    else
      flash[:errors] = @transaction.errors.full_messages
    end
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
