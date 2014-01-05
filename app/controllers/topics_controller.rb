class TopicsController < LoggedInController
  respond_to :html, :js
  before_action :load_topic, only: [:show, :edit, :update, :destroy, :publish]
  skip_before_filter :require_user_is_logged_in, only: :show

  def index
    @topics = Topic.order(:name).page(params[:page]).per(15)
    respond_with @topics
  end

  def show
    respond_with @topic
  end

  def new
    @topic = Topic.new
    respond_with @topic
  end

  def edit
    respond_with @topic
  end

  def create
    @topic = Topic.new topic_params
    flash[:notice] = 'Topic was successfully created.' if @topic.save
    respond_with @topic
  end

  def update
    if @topic.update topic_params
      flash[:notice] = 'Topic was successfully updated.'
    end
    respond_with @topic
  end

  def destroy
    @topic.destroy
    flash[:notice] = %(Topic "#{@topic.name}" was successfully destroyed.)
    respond_with @topic
  end

  private

  def load_topic
    @topic = Topic.find params[:id]
  end

  def topic_params
    params.require(:topic).permit(:name)
  end
end
