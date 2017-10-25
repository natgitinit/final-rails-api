class CreateGalleries < ActiveRecord::Migration[5.0]
  def change
    add_column :users do |t|
      t.string :username 
      t.timestamps
    end
  end
end
