class Recipe < ApplicationRecord
    has_many :recipe_ingredients
    has_many :cart_recipes
    has_many :ingredients, through: :recipe_ingredients
    has_many :carts, through: :cart_recipes

    validates :name, presence: true

    accepts_nested_attributes_for :ingredients

    def ingredients_attributes=(ingredient_attributes)
        ingredient_attributes.values.each do |ingredient_attribute|
            ingredient = Ingredient.find_or_create_by(ingredient_attribute)
            self.ingredients << ingredient
        end
    end

    def recipe_ingredients_attributes=(recipe_ingredient_attributes)
        recipe_ingredient_attributes.values.each do |recipe_ingredient_attribute|
            if recipe_ingredient_attribute[:ingredient_attributes][:name] != ""
                
                ingredient = Ingredient.find_or_create_by(:name => recipe_ingredient_attribute[:ingredient_attributes][:name])

                recipe_ingredient = RecipeIngredient.find_or_create_by(:ingredient_id => ingredient.id)
                recipe_ingredient.update(:quantity => recipe_ingredient_attribute[:quantity])

                self.recipe_ingredients << recipe_ingredient
            elsif recipe_ingredient_attribute[:ingredient_id] != ""
                ingredient = Ingredient.find_by(:id => recipe_ingredient_attribute[:ingredient_id])

                recipe_ingredient = RecipeIngredient.find_or_create_by(:ingredient_id => ingredient.id)
                recipe_ingredient.update(:quantity => recipe_ingredient_attribute[:quantity])

                self.recipe_ingredients << recipe_ingredient
            end
        end
    end

    # model scope methods
    def self.filter_by_ingredient(ingredient)
        self.all.includes(:ingredients).where(ingredients: { id: ingredient })
    end

    def self.containsmilk
        self.all.includes(:ingredients).where(ingredients: { name: 'Milk' } )
    end
end