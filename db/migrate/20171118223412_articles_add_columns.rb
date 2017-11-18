class ArticlesAddColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :abstract, :text
    add_column :articles, :image_url, :string 
  end
end
