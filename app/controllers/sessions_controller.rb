class SessionsController < ApplicationController
  layout "login"
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to blog_path(name: user.name)
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged Out"
  end

  def register
    @user = User.new
  end
end
