class TierlistsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy
    before_action :set_tierlist, only: [:show, :destroy]
  
    def index
      @tierlists = Tierlist.all
    end
  
    def show
      @can_add_item = current_user?(@tierlist.user)
      @tierlistitems = @tierlist.tierlistitems.order(:rank)
    end
  
    def create
      @tierlist = current_user.tierlists.build(tierlist_params)
      if @tierlist.save
        flash[:success] = "Tierlist created!"
        redirect_to root_url
      else
        @feed_items = current_user.feed.paginate(page: params[:page])
        @tierlist_feed_items = current_user.tierlist_feed.paginate(page: params[:page])
        render 'static_pages/home', status: :unprocessable_entity
      end
    end
  
    def destroy
      @tierlist.destroy
      flash[:success] = "Tierlist deleted"
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
  
    def tierlist_params
      params.require(:tierlist).permit(:list)
    end
  
    def correct_user
      @tierlist = current_user.tierlists.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @tierlist.nil?
    end
  end