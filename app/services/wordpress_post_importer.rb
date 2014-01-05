require 'diagnostic_messaging'

class WordpressPostImporter
  include ::DiagnosticMessaging

  def initialize(author, options={})
    @author = author
    @verbose = options[:verbose]
  end

  def import_from_yaml(yaml_data)
    posts_data = YAML::load yaml_data
    posts_data.each do |post_data|
      post = WordpressPost.new post_data
      insert_article_from_post post if import_this_post?(post)
    end
  end

  private

  def import_this_post?(post)
    post.is_a_post? && post.is_published?
  end

  def insert_article_from_post(post)
    article = @author.articles.new(
      title: post.title, body: post.body, published_at: post.published_at
    )
    begin
      article.save!
      notice "Imported: #{article.title}"
    rescue StandardError => e
      error "ERROR importing article #{article.title}: #{e.class.name} #{e.message}"
    end
  end

  class WordpressPost
    def initialize(wordpress_data)
      @wordpress_data = wordpress_data.with_indifferent_access
    end

    def is_a_post?
      @wordpress_data[:post_type] == 'post'
    end

    def is_published?
      @wordpress_data[:post_status] == 'publish'
    end

    def title
      @wordpress_data[:post_title]
    end

    def body
      @wordpress_data[:post_content]
    end

    def published_at
      Time.zone.parse @wordpress_data[:post_date_gmt] + ' UTC'
    end
  end
end
