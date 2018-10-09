# == Schema Information
#
# Table name: ingredients
#
#   id                  :integer            not null, primary key
#   name                :string     
#   created_at          :datetime           not null
#   updated_at          :datetime           not null
#

class IngredientsController < ApplicationController
    before_action :require_login
    before_action :set_ingredient, only: [:show, :edit, :update]
    before_action :set_recipe, only: [:show, :edit, :update]

    def index

    end

    def show

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
        
    end

    def update
        @ingredient.update(ingredient_params)
        @recipe_ingredient = RecipeIngredient.by_association(@ingredient.id, @recipe.id)[0]
        @recipe_ingredient.quantity = params[:ingredient][:recipe_ingredients_attributes]["0"][:quantity]
        @recipe_ingredient.save
        redirect_to recipe_ingredient_path(@recipe, @ingredient)
    end

    def destroy

    end

    private

    def set_ingredient
        @ingredient = Ingredient.find(params[:id])
    end

    def set_recipe
        @recipe = Recipe.find(params[:recipe_id])
    end

    def ingredient_params
        params.require(:ingredient).permit(:name, recipe_ids: [], recipe_ingredients_attributes: [:quantity])
    end
end
