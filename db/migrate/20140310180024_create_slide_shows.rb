class CreateSlideShows < ActiveRecord::Migration
  def change
    create_table :slide_shows do |t|
      t.integer :author_id
      t.string :title
      t.string :slug
      t.text :content

      t.timestamps
    end

    add_index :slide_shows, :slug, unique: true
    add_index :slide_shows, :author_id
    add_foreign_key :slide_shows, :accounts, column: :author_id
  end
end
