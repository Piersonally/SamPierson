class AddThemeToSlideShows < ActiveRecord::Migration
  def change
    add_column :slide_shows, :theme, :string, default: 'default'
  end
end
