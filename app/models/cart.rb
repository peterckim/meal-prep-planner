class Cart < ApplicationRecord
    belongs_to :user
    has_many :cart_recipes
    has_many :recipes, through: :cart_recipes
end
