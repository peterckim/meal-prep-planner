class CartRecipe < ApplicationRecord
    belongs_to :cart
    balongs_to :recipe
end
