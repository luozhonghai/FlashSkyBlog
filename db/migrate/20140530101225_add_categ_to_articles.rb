class AddCategToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :categ, :string
  end
end
