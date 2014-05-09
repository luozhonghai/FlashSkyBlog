class BlogController < ApplicationController
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
end
