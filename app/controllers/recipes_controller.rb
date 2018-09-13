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
        @recipe.update(recipe_params)

        redirect_to recipe_path(@recipe)
    end

    def destroy

    end

    private

    def recipe_params
        params.require(:recipe).permit(:name, :content, ingredient_ids: [], ingredients_attributes: [:name])
    end
end
