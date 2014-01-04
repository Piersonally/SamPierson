class ArticleForm
  include ActiveModel::Model

  attr_reader :article

  validates :title, presence: true

  def initialize(article, attributes={})
    @article = article
    @article.assign_attributes attributes
  end

  delegate :title, :body, :author_id, :published_at, :visible,
           :persisted?, :column_for_attribute,
           :to => :article

  def update(attributes)
    @article.assign_attributes attributes
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

  def persist!
    @article.save
  end
end
