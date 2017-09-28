class User < ApplicationRecord

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :transactions_received,
    primary_key: :id,
    foreign_key: :received_id,
    class_name: :Transaction

  has_many :transactions_given,
    primary_key: :id,
    foreign_key: :given_id,
    class_name: :Transaction

  attr_reader :password

  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return user if user && user.is_password?(password)
    nil
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def count_credits
    credits = 100
    self.transactions_received.each do |transaction|
      credits += transaction.number_credits
    end
    self.transactions_given.each do |transaction|
      credits -= transaction.number_credits
    end
    credits
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

end
