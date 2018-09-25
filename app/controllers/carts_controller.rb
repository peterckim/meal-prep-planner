class CartsController < ApplicationController
    def index

    end

    def show
        @cart = Cart.find_by(:id => session[:cart_id])
    end

    
end
