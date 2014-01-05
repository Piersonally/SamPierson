class Topic < ActiveRecord::Base
  has_and_belongs_to_many :articles

  validates :name, presence: true, uniqueness: true

  def self.topics_with_article_counts
    joins("INNER JOIN articles_topics ON articles_topics.topic_id = topics.id")
    .group("topics.id")
    .select("topics.id, topics.name, COUNT(articles_topics) AS article_count")
    .order("COUNT(articles_topics) DESC")
  end
end
