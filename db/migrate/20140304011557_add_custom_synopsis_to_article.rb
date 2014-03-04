class AddCustomSynopsisToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :custom_synopsis, :text
  end
end
