class User < ApplicationRecord

  has_secure_password

  validates :password, presence: true, length: { minimum: 3}
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_save { self.email.downcase! }

  def self.authenticate_with_credentials(email, password)
    User.find_by_email(email.strip.downcase)&.authenticate(password)
  end

end
