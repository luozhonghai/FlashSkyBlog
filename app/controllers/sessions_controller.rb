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
      @user_key = SecureRandom.hex(10)
      @user.verify_key = @user_key
      @user.save!
      UserNotifier.reset_password(@mail_str,@user,@user_key).deliver
    else
      @e = "true"
      redirect_to find_password_url(error: @e)
    end
  end

  def reset_password
    if(params[:user_id] !=nil and params[:key] != nil)
      @user = User.find(params[:user_id])
      @key = params[:key]
      if(@user.verify_key != @key)
        redirect_to login_url
      else
      end
    else
      redirect_to login_url
    end
  end

  def new_password
    @user = User.find(params[:id])
  end

  def register_notice
    @user = User.find(params[:id])
  end
end
