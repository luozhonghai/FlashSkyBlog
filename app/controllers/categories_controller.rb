class CategoriesController < ApplicationController
  def show
    @categ = Category.find(params[:id]).name
    @articles = Article.where(user_id: session[:blog_id], categ: @categ)
  end
end
