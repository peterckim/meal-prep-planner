class IngredientsController < ApplicationController
    before_action :require_login

    def index

    end

    def show
        @ingredient = Ingredient.find(params[:id])
        @recipe = Recipe.find(params[:recipe_id])
    end

    def new
        @ingredient = Ingredient.new
    end

    def create
        @ingredient = Ingredient.create(ingredient_params)
        redirect_to recipes_path
    end

    def edit
        @ingredient = Ingredient.find(params[:id])
        @recipe = Recipe.find(params[:recipe_id])
    end

    def update
        @ingredient = Ingredient.find(params[:id])
        @ingredient.update(ingredient_params)

        redirect_to ingredient_path(@ingredient)
    end

    def destroy

    end

    private

    def ingredient_params
        params.require(:ingredient).permit(:name, recipe_ids: [], recipes_attributes: [:name])
    end
end
