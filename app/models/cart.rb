# == Schema Information
#
# Table name: carts
#
#   id                  :integer            not null, primary key
#   user_id             :integer
#   created_at          :datetime           not null
#   updated_at          :datetime           not null
#

class Cart < ApplicationRecord
    belongs_to :user
    has_many :cart_recipes
    has_many :recipes, through: :cart_recipes
end
