class SessionsController < ApplicationController
  layout "login"
  def new
    @exist_users = User.all
  end

  def create
    user = User.find_by(name: params[:name])
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

  def find_password
    if (params[:error] != nil)
       @e = params[:error]
      render "find_password"
    end
  end

  def send_mail
    @user = User.find_by(name: params[:user_name])
    if(@user != nil)
      @mail_str = @user.email
      @mail_key = SecureRandom.hex(10)
      UserNotifier.reset_password(@mail_str,@user,@mail_key).deliver
    else
      @e = "true"
      redirect_to find_password_url(error: @e)
    end
  end

  def reset_password
    
  end
end
