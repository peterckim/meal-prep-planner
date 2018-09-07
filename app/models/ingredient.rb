class Ingredient < ApplicationRecord
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients
    accepts_nested_attributes_for :recipes
    
    validates :name, presence: true, uniqueness: true

    def recipes_attributes=(recipe_attributes)
        recipe_attributes.values.each do |recipe_attribute|
          recipe = Recipe.find_or_create_by(recipe_attribute)
          self.recipes << recipe
        end
    end
end
