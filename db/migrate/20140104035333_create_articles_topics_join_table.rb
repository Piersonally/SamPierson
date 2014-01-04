class CreateArticlesTopicsJoinTable < ActiveRecord::Migration
  def change
    create_table :articles_topics do |t|
      t.integer :article_id
      t.integer :topic_id
    end

    add_index :articles_topics, :article_id
    add_index :articles_topics, :topic_id
    add_foreign_key :articles_topics, :articles
    add_foreign_key :articles_topics, :topics
  end
end
