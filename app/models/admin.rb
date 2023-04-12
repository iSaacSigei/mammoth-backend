class Admin < ApplicationRecord
    has_secure_password
    has_many :lands
    has_many :users, through: :lands
end
