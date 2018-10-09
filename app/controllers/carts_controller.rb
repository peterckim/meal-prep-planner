# == Schema Information
#
# Table name: carts
#
#   id                  :integer            not null, primary key
#   user_id             :integer
#   created_at          :datetime           not null
#   updated_at          :datetime           not null
#

class CartsController < ApplicationController
    def index

    end

    def show
        @cart = Cart.find_by(:id => session[:cart_id])
    end

    
end
