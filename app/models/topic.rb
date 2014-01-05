class Topic < ActiveRecord::Base
  has_and_belongs_to_many :articles

  include Sluggable
  self.generate_slugs_from_column = :name

  validates :name, presence: true, uniqueness: true

  def self.topics_with_article_counts
    joins(
      "INNER JOIN articles_topics ON articles_topics.topic_id = topics.id",
      "INNER JOIN articles ON articles_topics.article_id = articles.id AND articles.visible = 't'"
    )
    .group("topics.id")
    .select("topics.id, topics.name, topics.slug, COUNT(articles_topics) AS article_count")
    .order("COUNT(articles_topics) DESC")
  end
end
