# == Schema Information
#
# Table name: users
#
#   id                  :integer            not null, primary key
#   name                :string  
#   email               :string
#   image               :string
#   uid                 :string
#   password            :string
#   created_at          :datetime           not null
#   updated_at          :datetime           not null
#

class User < ApplicationRecord
    has_secure_password

    has_one :cart

    validates :name, :email, presence: true
    validates :email, uniqueness: true
end
