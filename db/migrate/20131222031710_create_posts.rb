class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :author_id
      t.datetime :published_at

      t.timestamps
    end

    add_index :posts, :published_at
    add_index :posts, :author_id
    add_foreign_key :posts, :accounts, column: 'author_id'
  end
end
