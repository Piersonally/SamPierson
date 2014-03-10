class SlideShow < ActiveRecord::Base

  belongs_to :author, class_name: 'Account', inverse_of: :slide_shows

  include Sluggable
  self.generate_slugs_from_column = :title

  validates :author_id, :title, presence: true

  THEMES = %w[default beige blood moon night serif simple sky solarized]
end
