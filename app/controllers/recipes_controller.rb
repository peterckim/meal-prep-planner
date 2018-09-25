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
        @recipe = Recipe.find_by(:id => params[:id])
    end

    def update
        @recipe = Recipe.find_by(:id => params[:id])
        if @recipe.update(recipe_params)
            redirect_to recipe_path(@recipe)
        else
            render :edit
        end
    end

    def destroy

    end

    def add_to_cart
        @recipe = Recipe.find_by(:id => params[:id])
        CartRecipe.find_or_create_by(cart_id: session[:cart_id], recipe_id: params[:id])

        flash[:notice] = "Recipe successfully added"

        redirect_to recipe_path(@recipe)
    end

    def remove_from_cart
        recipe = Recipe.find_by(:id => params[:id])
        cart = Cart.find_by(:id => session[:cart_id])
        cart_recipe = CartRecipe.find_by(cart_id: cart.id, recipe_id: recipe.id)

        cart_recipe.destroy

        flash[:notice] = "Recipe successfully removed"
        redirect_to cart_path
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
        params.require(:recipe).permit(:name, :content, ingredient_ids: [], recipe_ingredients_attributes: [:quantity, :ingredient_id, ingredient_attributes: [:name]])
    end
end
