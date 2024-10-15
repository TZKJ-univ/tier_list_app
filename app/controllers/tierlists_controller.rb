class TierlistsController < ApplicationController
  before_action :set_tierlist, only: %i[show destroy edit update]
  before_action :check_edit_permission, only: %i[edit update destroy update]
  before_action :correct_user, only: %i[destroy]

  def new
    # unless logged_in?
    #   guest_user = User.create_guest_user
    #   log_in(guest_user)
    # end
    @tierlist = Tierlist.new
  end

  def edit
  end

  def update
    if @tierlist.update(tierlist_params)
      flash[:success] = 'Tierlist設定が更新されました'
      redirect_to @tierlist
    else
      render 'edit'
    end
  end

  def index
    @tierlists = Tierlist.where(public: true || current_user)
  end

  def show
    @can_add_item = ( current_user?(@tierlist.user) or @tierlist.editable_by_anyone )
    @can_vote = @tierlist.votable
    @tierlistitems = @tierlist.tierlistitems.order(:rank)
  end

  def create
    if logged_in?
      @tierlist = current_user.tierlists.build(tierlist_params)
    else
      @tierlist = Tierlist.new(tierlist_params)
    end
    if @tierlist.save
      flash[:success] = 'Tierlistが作成されました'
      redirect_to root_url
    else
      if logged_in?
        @feed_items = current_user.feed.paginate(page: params[:page])
        @tierlist_feed_items = current_user.tierlist_feed.paginate(page: params[:page])
        render 'static_pages/home', status: :unprocessable_entity
      else
        render 'new', status: :unprocessable_entity
      end
    end
  end

  def destroy
    @tierlist.destroy
    flash[:success] = 'Tierlistは削除されました'
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
    if logged_in?
      @tierlist = Tierlist.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if (@tierlist.user != current_user and (Tierlist.find_by(id: params[:id]).editable_by_anyone==false))
    else
      redirect_to root_url, status: :see_other
    end
  end

  def tierlist_params
    params.require(:tierlist).permit(:list, :editable_by_anyone, :public, :votable)
  end

  def check_edit_permission
    unless @tierlist.editable_by_anyone || @tierlist.user == current_user
      redirect_to tierlists_path, alert: '権限がありません'
    end
  end
end
