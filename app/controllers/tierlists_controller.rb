class TierlistsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :set_tierlist, only: %i[show destroy edit update]
  before_action :check_edit_permission, only: %i[edit update destroy update]

  def new
    @tierlist = Tierlist.new
  end

  def edit
  end

  def update
    if @tierlist.update(tierlist_params)
      flash[:success] = 'Tierlist updated!'
      redirect_to @tierlist
    else
      render 'edit'
    end
  end

  def index
    @tierlists = Tierlist.all
  end

  def show
    @can_add_item = ( current_user?(@tierlist.user) or @tierlist.editable_by_anyone )
    @tierlistitems = @tierlist.tierlistitems.order(:rank)
  end

  def create
    @tierlist = current_user.tierlists.build(tierlist_params)
    if @tierlist.save
      flash[:success] = 'Tierlist created!'
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      @tierlist_feed_items = current_user.tierlist_feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @tierlist.destroy
    flash[:success] = 'Tierlist deleted'
    if request.referrer.nil?
      redirect_back_or_to(root_url, status: :see_other)
    else
      redirect_back_or_to(root_url, status: :see_other)
    end
  end

  private

  def set_tierlist
    @tierlist = Tierlist.find(params[:id])
  end

  def correct_user
    @tierlist = current_user.tierlists.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @tierlist.nil?
  end

  def tierlist_params
    params.require(:tierlist).permit(:list, :editable_by_anyone)
  end

  def check_edit_permission
    unless @tierlist.editable_by_anyone || @tierlist.user == current_user
      redirect_to tierlists_path, alert: 'You do not have permission to edit this tierlist.'
    end
  end
end
