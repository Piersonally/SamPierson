class ArticleForm
  include ActiveModel::Model

  attr_reader :article

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
      persist
      true
    else
      false
    end
  end

  def topic_names
    @topic_names.join ", "
  end

  def topic_names=(names_string)
    # topic_names is stored as an array of strings
    @topic_names = names_string.split(/, \s*/)
  end

  # used in polymorphic_url
  def to_model
    @article
  end

  private

  def assign_attributes(attributes)
    attrs = attributes.with_indifferent_access
    if attrs.has_key? :topic_names
      self.topic_names = attrs.delete :topic_names
    end
    @article.assign_attributes attrs
  end

  def persist
    @article.transaction do
      @article.save
      update_article_topics
    end
  end

  def update_article_topics
    topics = retrieve_existing_topics_matching_names
    create_new_topics_where_necessary topics
    @article.topics = topics # HABTM: this line updates DB
  end

  def retrieve_existing_topics_matching_names
    Topic.where name: @topic_names
  end

  # Compares a the list of topic names (@topic_names)
  # with an array of Topics, creating any Topics where required to
  # make the array contain all Topics mentioned in @topic_names
  def create_new_topics_where_necessary(topics)
    @topic_names.each do |topic_name|
      unless topics.detect { |topic| topic.name == topic_name }
        topics << Topic.create!(name: topic_name)
      end
    end
  end
end
