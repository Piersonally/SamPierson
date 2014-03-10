class SlideShow < ActiveRecord::Base

  belongs_to :author, class_name: 'Account', inverse_of: :slide_shows

  include Sluggable
  self.generate_slugs_from_column = :title

  validates :author_id, :title, presence: true
end
