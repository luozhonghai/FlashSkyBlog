class PicCommentsController < ApplicationController
  before_action :set_pic_comment, only: [:show, :edit, :update, :destroy]

  # GET /pic_comments
  # GET /pic_comments.json
  def index
    @pic_comments = PicComment.all
  end

  # GET /pic_comments/1
  # GET /pic_comments/1.json
  def show
  end

  # GET /pic_comments/new
  def new
    @pic_comment = PicComment.new
  end

  # GET /pic_comments/1/edit
  def edit
  end

  # POST /pic_comments
  # POST /pic_comments.json
  def create
    if(session[:user_id] != nil)
      @pic_comment = PicComment.new(pic_comment_params)
    else
      user = User.find_by(name: params[:name])
      @pic_comment = PicComment.new
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        @pic_comment.user_name = user.name
        @pic_comment.user_id = user.id
        @pic_comment.description = params[:pic_comment][:description]
      else
        #redirect_to login_url, alert: "Invalid user/password combination"
      end
    end
    @picture  = Picture.find(session[:current_pic_id])
    respond_to do |format|
      if @pic_comment.save
        @picture.add_comment(@pic_comment)
        format.html { redirect_to @pic_comment, notice: 'Pic comment was successfully created.' }
        format.js
        format.json { render action: 'show', status: :created, location: @pic_comment }
      else
        format.html { render action: 'new' }
        format.js { @e = true } 
        format.json { render json: @pic_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pic_comments/1
  # PATCH/PUT /pic_comments/1.json
  def update
    respond_to do |format|
      if @pic_comment.update(pic_comment_params)
        format.html { redirect_to @pic_comment, notice: 'Pic comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pic_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pic_comments/1
  # DELETE /pic_comments/1.json
  def destroy
    @pic_comment.destroy
    respond_to do |format|
      format.html { redirect_to pic_comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pic_comment
      @pic_comment = PicComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pic_comment_params
      params.require(:pic_comment).permit(:user_name, :description, :user_id, :picture_id)
    end
end
