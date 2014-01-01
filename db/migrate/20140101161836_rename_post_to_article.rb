class RenamePostToArticle < ActiveRecord::Migration
  def up
    # So as to get all the Postgres sequences named correctly,
    # do this by creating a new table.
    
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :author_id
      t.datetime :published_at
      t.timestamps
      t.string :slug
    end

    add_index :articles, :published_at
    add_index :articles, :author_id
    add_index :articles, :slug
    add_foreign_key :articles, :accounts, column: 'author_id'
    
    connection.execute "INSERT INTO articles SELECT * FROM posts"

    drop_table :posts
  end
end
