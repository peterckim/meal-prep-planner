class WelcomeController < ApplicationController
    def home
        if session[:user_id]
            redirect_to recipes_path
        end
    end
end
