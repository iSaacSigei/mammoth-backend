class User < ApplicationRecord
    has_secure_password
    has_many :lands
    has_one :profile
    accepts_nested_attributes_for :profile
end
