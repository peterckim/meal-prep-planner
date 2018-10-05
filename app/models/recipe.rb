class Recipe < ApplicationRecord
    has_many :recipe_ingredients
    has_many :cart_recipes
    has_many :ingredients, through: :recipe_ingredients
    has_many :carts, through: :cart_recipes

    validates :name, presence: true

    accepts_nested_attributes_for :ingredients

    MEASUREMENTS = [
        /cups?/,
        /teaspoons?/,
        /tablespoons?/,
        /pints?/,
        /quarts?/,
        /gallons?/,
        /pounds?/,
        /ounces?/
    ]


    def ingredients_attributes=(ingredient_attributes)
        ingredient_attributes.values.each do |ingredient_attribute|
            ingredient = Ingredient.find_or_create_by(ingredient_attribute)
            self.ingredients << ingredient
        end
    end

    def recipe_ingredients_attributes=(recipe_ingredient_attributes)
        recipe_ingredient_attributes.values.each do |recipe_ingredient_attribute|
            if recipe_ingredient_attribute[:ingredient_attributes][:name].present?
                
                ingredient = Ingredient.find_or_create_by(:name => recipe_ingredient_attribute[:ingredient_attributes][:name])

                recipe_ingredient = RecipeIngredient.find_or_create_by(:ingredient_id => ingredient.id)
                recipe_ingredient.update(:quantity => recipe_ingredient_attribute[:quantity])

                self.recipe_ingredients << recipe_ingredient
            elsif recipe_ingredient_attribute[:ingredient_id].present?
                ingredient = Ingredient.find_by(:id => recipe_ingredient_attribute[:ingredient_id])

                recipe_ingredient = RecipeIngredient.find_or_create_by(:ingredient_id => ingredient.id)
                recipe_ingredient.update(:quantity => recipe_ingredient_attribute[:quantity])

                self.recipe_ingredients << recipe_ingredient
            end
        end
    end

    def self.find_or_create_from_api(arrayOfRecipes)
        arrayOfRecipes.each do |recipe_data|
            recipe = Recipe.find_or_create_by(:name => recipe_data['recipe']['label'])
            recipe.update(:image => recipe_data['recipe']['image'])
            recipe_data['recipe']['ingredients'].each do |ingredient_data|
                ingredient_text_parsed = ingredient_data['text'].split(" ")
                MEASUREMENTS.each do |measurement|
                    if ingredient_data['text'].include?(measurement.to_s)
                        ingredient_text_parsed = ingredient_data['text'].partition(measurement.to_s)
                        break
                    end
                end
                ingredient = Ingredient.find_or_create_by(:name => ingredient_text_parsed[-1])
                recipe_ingredient = RecipeIngredient.find_or_create_by(:recipe_id => recipe.id, :ingredient_id => ingredient.id)
                recipe_ingredient.update(:quantity => ingredient_text_parsed[0...-1].join)
                recipe.recipe_ingredients << recipe_ingredient
            end
        end
    end

    # model scope methods
    def self.filter_by_ingredient(ingredient_name)
        self.all.includes(:ingredients).where(ingredients: { name: ingredient_name.downcase })
    end

    def self.containsmilk
        self.all.includes(:ingredients).where(ingredients: { name: 'Milk' } )
    end
end