class RecipesController < ApplicationController
    before_action :require_login
    def index
        @ingredients = Ingredient.all

        if !params[:ingredient].blank?
            @recipes = Recipe.filter_by_ingredient(params[:ingredient])
        else
            @recipes = Recipe.all
        end
    end

    def show
        @recipe = Recipe.find(params[:id])
    end

    def new
        @recipe = Recipe.new
    end

    def create
        binding.pry
        @recipe = Recipe.new(recipe_params)
        if @recipe.save
            redirect_to recipe_path(@recipe)
        else
            render :new
        end
    end

    def edit
        @recipe = Recipe.find_by(:id => params[:id])
    end

    def update
        @recipe = Recipe.find_by(:id => params[:id])
        if params[:recipe][:recipe_ingredients_attributes]["0"][:ingredient_attributes][:name] == "" || params[:recipe][:recipe_ingredients_attributes]["0"][:ingredient_attributes][:name] == nil
            @recipe.update(params.require(:recipe).permit(:name, :content, ingredient_ids: []))
            redirect_to recipe_path(@recipe)
        else
            @recipe.update(recipe_params)
            redirect_to recipe_path(@recipe)
        end
    end

    def destroy

    end

    private

=begin
    params = {
        recipe: {
            name: "Name",
            content: "Content",

            ingredient_ids: [],

            recipe_ingredients_attributes: {
                0: {
                    quantity: "quantity",
                    ingredient_attributes: {
                        name: "Name"
                    }
                }
            }
        }
    }
=end

    def recipe_params
        params.require(:recipe).permit(:name, :content, ingredient_ids: [], recipe_ingredients_attributes: [:quantity, ingredient_attributes: [:name]])
    end
end
