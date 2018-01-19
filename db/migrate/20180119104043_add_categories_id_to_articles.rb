class AddCategoriesIdToArticles < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :articles, :category
  end
end
