class User < ApplicationRecord
  VALID_EMAIL_REGEX = Regexp.new(Settings.user.email_regex, Regexp::IGNORECASE)

  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.user.name_max_length}
  validates :email, presence: true,
            length: {maximum: Settings.user.email_max_length},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COS
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost:
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
