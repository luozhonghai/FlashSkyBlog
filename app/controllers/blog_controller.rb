class BlogController < ApplicationController
  include BlogHelper
  before_action :authorize_post, only: :post
  def index
    #view a certain blog
    if(params[:name] != nil)
      @user = User.find_by_name(params[:name])
      if(@user)
        @articles = Article.find_all_by_user_id(@user.id)
        session[:blog_id] = @user.id
        @archive = Article.where(user_id: @user.id).select("year,month,count(id) as amount").group("year","month")
      end
    #view my blog
    elsif(session[:user_id] != nil)  
      @user = User.find_by_id(session[:user_id])
      redirect_to blog_path(name: @user.name)
    else
      redirect_to login_url, notice: "Please log in"
    end
  end


# from a certain article or comment submit
  def show
    if(params[:article_id] != nil)
      @article = Article.find(params[:article_id])
      session[:current_article_id] = params[:article_id]
    else
      @article = Article.find(session[:current_article_id])
    end
    session[:blog_id] = User.find_by_name(params[:name])
    @comment = Comment.new
  end

  #post a new article
  def post
    @article = Article.new
    @category_list = Category.find_all_by_user_id(session[:user_id])
  end

  def edit_article
    @article = Article.find(params[:article_id])
    @category_list = Category.find_all_by_user_id(session[:user_id])
  end

  def gallery
    @user = User.find_by_name(params[:name])
    @pictures = Picture.find_all_by_user_id(@user.id)
    session[:blog_id] = @user.id
  end

  def save
    user = User.find(session[:user_id]);
    if(params[:picture] == nil || params[:picture][:file] == nil)
      redirect_to(action: 'gallery',name: user.name)
      return
    end
    @picture = Picture.new
    picture_field = params[:picture][:file]  
    @picture.name = base_part_of(picture_field.original_filename)
    @picture.title = params[:picture][:title] 
    @picture.content_type = picture_field.content_type.chomp
    @picture.data = picture_field.read
    if(@picture.save)
      user.add_picture(@picture);
      redirect_to(action: 'gallery', name: user.name)
    else
      render(action: 'gallery', name: user.name)
    end   
  end

  def picture
    @picture = Picture.find(params[:id])
    send_data(@picture.data, filename: @picture.name, type: @picture.content_type, disposition: "inline")
  end

  def album
    @user = User.find_by_name(params[:name])
    @picture = Picture.where(user_id: @user.id).find(params[:id])
  end

  def archive
    @user = User.find_by_name(params[:name])
    @articles = Article.where(user_id: @user.id, month: params[:month], year: params[:year])
  end

  def edit_category
    if(params[:add_category_name] != nil)
      @category = Category.new
      @category.user_id = User.find(session[:user_id]).id
      @category.name = params[:add_category_name]
      respond_to do |format|
      if @category.save
        format.js {@category_list = Category.find_all_by_user_id(session[:user_id])}
      end
    end

    elsif(params[:delete_category_id] != nil)
      @category = Category.find(params[:delete_category_id])
      @category.destroy 
      respond_to do |format|
        format.js {@category_list = Category.find_all_by_user_id(session[:user_id])}
      end
    end
  end

  def delete_article
    article = Article.find(params[:article_id])
    article.destroy
    redirect_to(blog_path(User.find_by_id(session[:blog_id]).name))
  end
end
