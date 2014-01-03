class ArticlesController < LoggedInController
  respond_to :html
  before_action :load_article, only: [:show, :edit, :update, :destroy, :publish]
  skip_before_filter :require_user_is_logged_in, only: :show

  def index
    @articles = current_user.articles.order 'published_at DESC'
    respond_with @articles
  end

  def show
    respond_with @article
  end

  def new
    @article = current_user.articles.new
    respond_with @article
  end

  def edit
    respond_with @article
  end

  def create
    @article = current_user.articles.new article_params
    flash[:notice] = 'Article was successfully created.' if @article.save
    respond_with @article
  end

  def update
    if @article.update article_params
      flash[:notice] = 'Article was successfully updated.'
    end
    respond_with @article
  end

  def destroy
    @article.destroy
    flash[:notice] = %(Article "#{@article.title}" was successfully destroyed.)
    respond_with @article
  end

  def publish
    unless @article.published?
      @article.update_attributes! published_at: Time.now
      flash[:notice] = %(Article "#{@article.title}" has been published.)
    end
    redirect_to @article
  end

  private
    def load_article
      if user_logged_in?
        @article = Article.find_by_slug! params[:id]
      else
        @article = Article.visible.find_by_slug! params[:id]
      end
    end

    def article_params
      params.require(:article).permit(:title, :body, :published_at, :visible)
    end
end
