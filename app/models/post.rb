class Post < ActiveRecord::Base

  belongs_to :author, class_name: 'Account', inverse_of: :posts

  validates :title, :author_id, presence: true

  scope :published, -> {
    where('published_at IS NOT NULL').order('published_at DESC')
  }

  def published?
    !!published_at
  end
end
