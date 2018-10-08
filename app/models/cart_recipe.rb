# == Schema Information
#
# Table name: cart_recipes
#
#   id                  :integer            not null, primary key
#   cart_id             :integer     
#   recipe_id           :integer
#   created_at          :datetime           not null
#   updated_at          :datetime           not null
#

class CartRecipe < ApplicationRecord
    belongs_to :cart
    belongs_to :recipe
end
