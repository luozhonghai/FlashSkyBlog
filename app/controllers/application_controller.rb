class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
    #avoid post article throudh wrong url
    def authorize_post
      user_login = User.find(session[:user_id])
      user_blog = User.find_by(name: params[:name])
      unless (user_login and user_login == user_blog)
        redirect_to login_url, notice: "Please log in"
      end
    end
end
