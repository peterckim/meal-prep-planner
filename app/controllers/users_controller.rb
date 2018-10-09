# == Schema Information
#
# Table name: users
#
#   id                  :integer            not null, primary key
#   name                :string  
#   email               :string
#   image               :string
#   uid                 :string
#   password            :string
#   created_at          :datetime           not null
#   updated_at          :datetime           not null
#

class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            cart = Cart.find_or_create_by(:user_id => @user.id)
            session[:user_id] = @user.id
            session[:cart_id] = cart.id

            redirect_to recipes_path
        else
            render :new
        end
    end

    def show
        @user = User.find_by(:id => params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
end
