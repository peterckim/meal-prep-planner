class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    private

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        if session[:user_id]
            return User.find(session[:user_id])
        elsif user
            session[:user_id] = user.id
        else
            nil
        end
    end

    def require_login
        return head(:forbidden) unless session.include? :user_id
    end
end
