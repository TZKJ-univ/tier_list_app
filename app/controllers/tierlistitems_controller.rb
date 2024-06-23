class TierlistitemsController < ApplicationController
  before_action :set_tierlist
  before_action :set_tierlistitem, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @tierlistitem = @tierlist.tierlistitems.build
  end

  def create
    @tierlistitem = @tierlist.tierlistitems.build(tierlistitem_params)
    if @tierlistitem.save
      flash[:success] = "Tierlist item created!"
      redirect_to @tierlist
    else
      flash[:error] = "Failed to create tierlist item."
      render 'tierlists/show'
    end
  end

  def edit
  end

  def update
    if @tierlistitem.update(tierlistitem_params)
      flash[:success] = "Tierlist item updated!"
      redirect_to @tierlist
    else
      render 'edit'
    end
  end

  def destroy
    @tierlistitem.destroy
    flash[:success] = "Tierlist item deleted!"
    redirect_to @tierlist
  end

  private

  def set_tierlist
    @tierlist = Tierlist.find(params[:tierlist_id])
  end

  def set_tierlistitem
    @tierlistitem = Tierlistitem.find(params[:id])
  end

  def tierlistitem_params
    params.require(:tierlistitem).permit(:listitem, :rank)
  end

  def correct_user
    unless current_user == @tierlist.user
      flash.now[:error] = "You are not authorized to perform this action."
      redirect_to root_url
    end
  end
end