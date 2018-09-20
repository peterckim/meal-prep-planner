class IngredientsController < ApplicationController
    before_action :require_login

    def index

    end

    def show
        @ingredient = Ingredient.find(params[:id])
        @recipe = Recipe.find(params[:recipe_id])
    end

    def new
        if params[:recipe_id]
            if !Recipe.exists?(params[:recipe_id])
                redirect_to recipes_path, alert: "Recipe not found."
            else
                @recipe = Recipe.find(params[:recipe_id])
                @ingredient = Ingredient.new(recipe_ids: [params[:recipe_id]])
            end
        else
            @ingredient = Ingredient.new
        end
    end

    def create
        @ingredient = Ingredient.new(ingredient_params)
        @ingredient.recipe_ingredients.last.recipe_id = params[:ingredient][:recipe_ids][-1].to_i
        if @ingredient.save
            redirect_to recipes_path
        else
            render :new
        end
    end

    def edit
        @ingredient = Ingredient.find(params[:id])
        @recipe = Recipe.find(params[:recipe_id])
    end

    def update
        @recipe = Recipe.find(params[:recipe_id])
        @ingredient = Ingredient.find(params[:id])
        @ingredient.update(ingredient_params)
        @recipe_ingredient = RecipeIngredient.by_association(@ingredient.id, @recipe.id)[0]
        @recipe_ingredient.quantity = params[:ingredient][:recipe_ingredients_attributes]["0"][:quantity]
        @recipe_ingredient.save
        redirect_to recipe_ingredient_path(@recipe, @ingredient)
    end

    def destroy

    end

    private

    def ingredient_params
        params.require(:ingredient).permit(:name, recipe_ids: [], recipe_ingredients_attributes: [:quantity])
    end
end
