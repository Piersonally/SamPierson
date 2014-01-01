class AddVisibleToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :visible, :boolean, default: false
    add_index :articles, :visible
  end
end
