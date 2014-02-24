class QuotationsController < LoggedInController
  respond_to :html, :js
  skip_before_filter :require_user_is_logged_in, only: :show
  before_filter :require_admin, except: [ :show ]
  before_filter :load_quotation, except:[:index, :new, :create]

  def index
    @quotes = Quotation.page(params[:page]).per(15)
    respond_with @quotes
  end

  def show
    respond_with @quote
  end

  def new
    @quote = current_user.quotations.new
  end

  def edit
    respond_with @quote
  end

  def create
    @quote = current_user.quotations.new quotation_params
    flash[:notice] = 'Quotation was successfully created.' if @quote.save
    respond_with @quote
  end

  def update
    if @quote.update quotation_params
      flash[:notice] = 'Quotation was successfully updated.'
    end
    respond_with @quote
  end

  def destroy
    @quote.destroy
    flash[:notice] = %(Quotation by #{@quote.author} was successfully destroyed.)
    respond_with @quote
  end

  private

  def load_quotation
    @quote = Quotation.find params[:id]
  end

  def quotation_params
    params.require(:quotation).permit(
      :author, :quote, :source, :when
    )
  end
end
