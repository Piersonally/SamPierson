class AddBodyLangToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :body_lang, :string, default: 'markdown'
  end
end
