class Admin < ApplicationRecord
    has_secure_password
    has_many :lands
    has_many :users, through: :lands
    validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
