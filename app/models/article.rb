class Article < ActiveRecord::Base

  belongs_to :author, class_name: 'Account', inverse_of: :articles

  before_validation :generate_slug

  validates :title, :author_id, :slug, presence: true
  validates :slug, uniqueness: true

  scope :visible, -> {
    where(visible: true).order('published_at DESC')
  }

  def published?
    !!published_at
  end

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize if slug.blank? && title.present?
  end
end
