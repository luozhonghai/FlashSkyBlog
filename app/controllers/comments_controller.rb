class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end


  # POST /comments
  # POST /comments.json
  def create

    if(session[:user_id] != nil)
      @comment = Comment.new(comment_params)
    else
      user = User.find_by_name(params[:name])
      @comment = Comment.new
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        @comment.user = user.name
        @comment.mail = user.email
        @comment.description = params[:comment][:description]
      else
        #redirect_to login_url, alert: "Invalid user/password combination"
      end
    end
    @article  = Article.find(session[:current_article_id])
   
    respond_to do |format|
      if @comment.save  
        @article.add_comment(@comment)
        #  format.html { render template: "blog/show"} blog_show_url
        format.html { redirect_to blog_show_path(article_id: @article), notice: 'Comment was successfully created.' }
        format.js 
        format.json { render action: 'show', status: :created, location: @comment }
      else
       # format.html { render action: 'new' }
        format.html { render partial: "form",  locals: {comment: @comment}} #doesn`t work when use ajax(remote:true)!
        format.js {
                   #@comment = Comment.new
                   @e=true }   # work when use ajax(remote:true)! and write two lines
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user, :mail, :description)
    end
end
