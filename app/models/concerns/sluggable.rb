module Sluggable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_accessor :generate_slugs_from_column
  end

  included do
    validates :slug, presence: true,
                     uniqueness: true,
                     if: -> { self.class.generate_slugs_from_column.present? }

    before_validation :generate_slug
  end

  def to_param
    slug || id
  end

  private

  def generate_slug
    return unless slugged_column.present?
    if slug.blank? && send(slugged_column).present?
      self.slug = send(slugged_column).parameterize
    end
  end

  def slugged_column
    self.class.generate_slugs_from_column
  end
end
