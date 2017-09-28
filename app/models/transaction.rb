
##This velidation is important.
##We do not want users to be able to send a negative number of credits!
class TransactionValidator < ActiveModel::Validator
  def validate(record)
    if record.number_credits > record.user_given.count_credits
      record.errors[:number_credits] << "cannot be greater than the number you have"
    end
    if record.number_credits <= 0
      record.errors[:number_credits] << "must be positive"
    end
    if record.user_received.nil?
      record.errors[:user_received] << "must exist"
    end
  end
end

class Transaction < ApplicationRecord

  include ActiveModel::Validations
  validates_with TransactionValidator

  belongs_to :user_received,
    primary_key: :id,
    foreign_key: :received_id,
    class_name: :User

  belongs_to :user_given,
    primary_key: :id,
    foreign_key: :given_id,
    class_name: :User

end
