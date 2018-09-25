require 'securerandom'

class SessionsController < ApplicationController
    def new
      @user = User.new
    end

    def create
      if auth
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
          u.image = auth['info']['image']
          u.password = SecureRandom.hex
        end
     
        session[:user_id] = @user.id
        redirect_to recipes_path
      else
        @user = User.find_by(:email => params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
          cart = Cart.find_or_create_by(:user_id => @user.id)
          session[:user_id] = @user.id
          session[:cart_id] = cart.id
          redirect_to user_path(@user)
        else
          flash[:notice] = "Invalid email/password combination."
          @user = User.new
          render 'sessions/new'
        end
      end
    end

    def destroy
      if logged_in?
        reset_session
      end
      
      redirect_to root_path
    end
   
    private
   
    def auth
      request.env['omniauth.auth']
    end
end