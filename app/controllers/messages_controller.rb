class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    if(session[:user_id] != nil)
      @message = Message.new(message_params)
    else
      user = User.find_by(name: params[:name])
      @message = Message.new
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        @message.user_name = user.name
        @message.description = params[:message][:description]
      else
        redirect_to login_url, alert: "Invalid user/password combination"
        return
      end
    end
    @blog_user  = User.find(session[:blog_id])
    respond_to do |format|
      if @message.save
        @blog_user.add_message(@message)
        #format.html { redirect_to message_show_url(name: @blog_user.name), notice: 'Message was successfully created.' }
        format.html { @message = Message.new;
        @user = @blog_user;
        render 'blog/message', notice: 'Message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :user_name, :description)
    end
end
