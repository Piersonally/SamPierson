class SlideShowsController < LoggedInController
  respond_to :html, :js
  skip_before_filter :require_user_is_logged_in, only: :present
  before_filter :require_admin, except: [ :present ]
  layout 'reveal', only: [:present]

  def index
    @slide_shows = SlideShow.page(params[:page]).per(15)
    respond_with @slide_shows
  end

  def show
    respond_with @slide_show = slide_show
  end

  def new
    @slide_show = current_user.slide_shows.new
  end

  def edit
    @slide_show = slide_show
  end

  def create
    @slide_show = current_user.slide_shows.new slide_show_params
    flash[:notice] = 'Slide show was successfully created.' if @slide_show.save
    respond_with @slide_show
  end

  def update
    @slide_show = slide_show
    if @slide_show.update slide_show_params
      flash[:notice] = 'Slide show was successfully updated.'
    end
    respond_with @slide_show
  end

  def destroy
    slide_show.destroy
    flash[:notice] = %(Slide show "#{slide_show.title}" was successfully destroyed.)
    respond_with slide_show
  end

  def present
    respond_with @slide_show = slide_show
  end

  private

  def slide_show
    @slide_show ||= SlideShow.find_by_slug! params[:id]
  end

  def slide_show_params
    params.require(:slide_show).permit(
      :title, :slug, :content
    )
  end
end
