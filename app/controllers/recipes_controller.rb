# == Schema Information
#
# Table name: recipes
#
#   id                  :integer            not null, primary key
#   name                :string     
#   instructions        :string
#   image               :string
#   created_at          :datetime           not null
#   updated_at          :datetime           not null
#

class RecipesController < ApplicationController
    before_action :require_login
    before_action :set_recipe, only: [:show, :edit, :update, :add_to_cart, :remove_from_cart]
    
    def index
        if params[:ingredient].present?
            # use heroku vars
            edamam = EdamamService.new
            body = edamam.recipes(params[:ingredient])
            Recipe.find_or_create_from_api(body)
            @recipes = Recipe.filter_by_ingredient(params[:ingredient])
        end

        recipes = Recipe.all
        
        respond_to do |format|
            format.html { render :index }
            format.json { render json: recipes.to_json }
        end
    end

    def show
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @recipe }
        end
    end

    def new
        @recipe = Recipe.new
        5.times {@recipe.recipe_ingredients.build}

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

    end

    def update
        if @recipe.update(recipe_params)
            redirect_to recipe_path(@recipe)
        else
            render :edit
        end
    end

    def destroy

    end

    def add_to_cart
        CartRecipe.find_or_create_by(cart_id: session[:cart_id], recipe_id: params[:id])

        flash[:notice] = "Recipe successfully added"

        redirect_to recipe_path(@recipe)
    end

    def remove_from_cart
        cart = Cart.find_by(:id => session[:cart_id])
        cart_recipe = CartRecipe.find_by(cart_id: cart.id, recipe_id: @recipe.id)

        cart_recipe.destroy

        flash[:notice] = "Recipe successfully removed"
        redirect_to cart_path
    end



    private

    def set_recipe
        @recipe = Recipe.find_by(:id => params[:id])
    end

    def recipe_params
        params.require(:recipe).permit(:name, :content, ingredient_ids: [], recipe_ingredients_attributes: [:quantity, :ingredient_id, ingredient_attributes: [:name]])
    end
end
