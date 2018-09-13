class Recipe < ApplicationRecord
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    accepts_nested_attributes_for :ingredients

    validates :name, presence: true, uniqueness: true

    def self.filter_by_ingredient(ingredient)
        self.all.includes(:ingredients).where(ingredients: { id: ingredient })
    end

    def self.containsmilk
        self.all.includes(:ingredients).where(ingredients: { name: 'Milk' } )
    end

    def ingredients_attributes=(ingredient_attributes)
        ingredient_attributes.values.each do |ingredient_attribute|
            ingredient = Ingredient.find_or_create_by(ingredient_attribute)
            self.ingredients << ingredient
        end
    end
end
