class User < ApplicationRecord
    has_secure_password
    has_many :lands
    has_one :profile
    accepts_nested_attributes_for :profile
    validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
