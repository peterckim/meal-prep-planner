class User < ApplicationRecord
    has_secure_password

    has_one :cart
    validates :name, :email, presence: true
    validates :email, uniqueness: true

    
end
