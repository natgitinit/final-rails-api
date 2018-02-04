class AddUpVoteToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :upvote_count, :integer
  end
end
