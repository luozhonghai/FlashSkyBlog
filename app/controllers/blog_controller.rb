class BlogController < ApplicationController
  include BlogHelper

  def index
  	@articles = Article.all;
  end


# from a certain article or comment submit
  def show

  	if(params[:article_id] != nil)
  		@article = Article.find(params[:article_id]);
  		session[:current_article_id] = params[:article_id];
 	  else
 	    @article = Article.find(session[:current_article_id]);
    end

  	@comment = Comment.new;
  end

  #post a new article
  def post
    @article = Article.new
  end

  def gallery
    @pictures = Picture.all
  end

  def save
    if(params[:picture] == nil || params[:picture][:file] == nil)
      redirect_to(action: 'gallery')
      return
    end
    @picture = Picture.new
    picture_field = params[:picture][:file]  
    @picture.name = base_part_of(picture_field.original_filename)
    @picture.title = params[:picture][:title] 
    @picture.content_type = picture_field.content_type.chomp
    @picture.data = picture_field.read
    if(@picture.save)
        redirect_to(action: 'gallery')
    else
        render(action: 'gallery') 
    end   
  end

  def picture
    @picture = Picture.find(params[:id])
    send_data(@picture.data, filename: @picture.name, type: @picture.content_type, disposition: "inline")
  end

  def album
    @picture = Picture.find(params[:id])
  end
end
