class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness:  { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by('LOWER(email) = ?', email.strip.downcase)
    # If the user exists AND the password entered is correct return user otherwise return nil.
    user && user.authenticate(password) ? user : nil
  end
end
