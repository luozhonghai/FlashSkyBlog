class BlogController < ApplicationController
  include BlogHelper
  before_action :authorize_post, only: [:post, :edit_article, :delete_article, :delete_comment]
  def index
    #view a certain blog
    if(params[:name] != nil)
      @user = User.find_by(name: params[:name])
      if(@user)
        @articles = @user.articles
        session[:blog_id] = @user.id
        @archive = @user.articles.select("year,month,count(id) as amount").group("year","month")
        @category_list = Category.where(user_id:@user.id)
        @articles_desc=@user.articles.order("id desc").limit(10)
        @comments_desc =Comment.order("id desc").collect { |comment| 
          if Article.find(comment.article_id).user_id == @user.id
             comment
          else
             nil
           end
          }.compact
      end
    #view my blog
    elsif(session[:user_id] != nil)  
        @user = User.find(session[:user_id])
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
    session[:blog_id] = User.find_by(name: params[:name]).id
    @comment = Comment.new
  end

  #post a new article
  def post
    @article = Article.new
    session[:article_post] = @article.id
    @category_list = Category.where(user_id: session[:user_id])
  end

  def edit_article
    @article = Article.find(params[:article_id])
    session[:article_post] = params[:article_id]
    @category_list = Category.where(user_id: session[:user_id])
  end

  def delete_article
    user_name = article.user.name
    article = Article.find(params[:article_id])
    article.destroy
    redirect_to(blog_path(user_name))
  end

  def delete_comment
    if (params[:article] != nil)
      article = Article.find(params[:article])
      comment = article.comments.find(params[:comment_id])
      comment.destroy
      redirect_to(article_show_url(name: article.user.name, article_id: article))
    end
    if (params[:picture] != nil)
      picture = Picture.find(params[:picture])
      comment = picture.pic_comments.find(params[:comment_id])
      comment.destroy
      redirect_to(album_show_url(name: picture.user.name, id: picture))
    end
    if (params[:user] != nil)
      user = User.find(params[:user])
      comment = user.messages.find(params[:comment_id])
      comment.destroy
      redirect_to(message_show_url(name: user.name))
    end
  end

  def edit_picture
    @picture = Picture.find(params[:id])
    session[:picture_id] = params[:id]
    respond_to do |format|
        format.js {}
    end
  end

  def update_picture
    if (params[:picture]!=nil)
      @picture = Picture.find(session[:picture_id])
      @picture.title = params[:picture][:title]
      @picture.description = params[:picture][:description]
      @picture.save
      redirect_to(gallery_show_url(name: @picture.user.name))    
    end
  end

  def delete_picture
    picture = Picture.where(user_id: session[:user_id]).find(params[:id])
    user_name = picture.user.name
    picture.destroy
    redirect_to(gallery_show_url(name: user_name))
  end

  def gallery
    @user = User.find_by(name: params[:name])
    @pictures = @user.pictures
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
    @user = User.find_by(name: params[:name])
    @picture = Picture.where(user_id: @user.id).find(params[:id])
    session[:blog_id] = User.find_by(name: params[:name]).id
    @pic_comment = PicComment.new
    session[:current_pic_id] = params[:id]
  end

  def archive
    @user = User.find_by(name: params[:name])
    @articles = Article.where(user_id: @user.id, month: params[:month], year: params[:year])
  end

  def edit_category
    if(params[:add_category_name] != nil)
      @category = Category.new
      @category.user_id = User.find(session[:user_id]).id
      @category.name = params[:add_category_name]
      respond_to do |format|
      if @category.save
        format.js {@category_list = Category.find_all_by_user_id(session[:user_id])
         }
      end
    end

    elsif(params[:delete_category_id] != nil)
      @category = Category.find(params[:delete_category_id])
      @category.destroy 
      respond_to do |format|
        format.js {@category_list = Category.find_all_by_user_id(session[:user_id])
          }
      end
    end
  end

  def message
    @user = User.find_by(name: params[:name])
    @message = Message.new
    session[:blog_id] = @user.id
  end


end
