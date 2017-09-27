class Transaction < ApplicationRecord

  belongs_to :user_received,
    primary_key: :id,
    foreign_key: :received_id,
    class_name: :User

  belongs_to :user_given,
    primary_key: :id,
    foreign_key: :given_id,
    class_name: :User
    
end
