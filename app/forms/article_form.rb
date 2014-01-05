class ArticleForm
  include ActiveModel::Model

  attr_reader :article
  attr_accessor :topic_names

  validates :title, presence: true

  def initialize(article, attributes={})
    @article = article
    @topic_names = @article.topics.map(&:name)
    assign_attributes attributes
  end

  delegate :title, :body, :author_id, :published_at, :visible,
           :persisted?, :column_for_attribute,
           :to => :article

  def update(attributes)
    assign_attributes attributes
    save
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  # used in polymorphic_url
  def to_model
    @article
  end

  private

  def assign_attributes(attributes)
    attrs = attributes.with_indifferent_access
    if attrs.has_key? :topic_names
      self.topic_names = attrs.delete(:topic_names).split(' ')
    end
    @article.assign_attributes attrs
  end

  def persist!
    @article.transaction do
      @article.save
      update_article_topics
    end
  end

  def update_article_topics
    return unless topic_names
    topics = Topic.where name: topic_names
    topic_names.each do |topic_name|
      unless topics.detect { |t| t.name == topic_name }
        topics << Topic.create!(name: topic_name)
      end
    end
    @article.topics = topics
  end
end
