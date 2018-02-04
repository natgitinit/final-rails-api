class ChangeUpvoteColumn < ActiveRecord::Migration[5.0]
  def change
    change_column :articles, :upvote_count, :integer, default: 0
  end
end
