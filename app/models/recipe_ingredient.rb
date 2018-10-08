# == Schema Information
#
# Table name: recipe_ingredients
#
#   id                  :integer            not null, primary key
#   recipe_id           :integer
#   ingredient_id       :integer
#   quantity            :string
#   created_at          :datetime           not null
#   updated_at          :datetime           not null
#

class RecipeIngredient < ApplicationRecord
    belongs_to :recipe
    belongs_to :ingredient
    # validates :ingredient_id, uniqueness: { scope: :recipe_id }

    def self.by_association(ingredient_id, recipe_id)
        where(ingredient_id: ingredient_id, recipe_id: recipe_id)
    end

    def ingredient_attributes=(ingredient_attribute)
        ingredient_attribute.values.each do |attribute|
            ingredient = Ingredient.find_or_create_by(attribute)
            self.ingredient = ingredient
        end
    end

end
