class Ingredient < ApplicationRecord
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients
    accepts_nested_attributes_for :recipes
    
    validates :name, presence: true

    def recipes_attributes=(recipe_attributes)
        recipe_attributes.values.each do |recipe_attribute|
          recipe = Recipe.find_or_create_by(recipe_attribute)
          self.recipes << recipe
        end
    end
    


    # HOW DO I GET RECIPE HERE
    def recipe_ingredients_attributes=(recipe_ingredient_attributes)
        recipe_ingredient_attributes.values.each do |recipe_ingredient_attribute|

            self.recipe_ingredients = self.recipe_ingredients.drop(1)
            recipe_ingredient = RecipeIngredient.create(:quantity => recipe_ingredient_attribute[:quantity])
            self.recipe_ingredients << recipe_ingredient
        end
    end
end
