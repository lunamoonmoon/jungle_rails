class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6, maximum: 255}
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    # LOWER is case insensitive and persorms a comparison
    # .downcase converts the param to lowercase and .strip removes any spaces at begining or end
    user = where('LOWER(email) = ?', email&.downcase&.strip).first

    if user && user.authenticate(password)
      # log user in
      user
    else
      # render login form
      nil
    end
  end
end
