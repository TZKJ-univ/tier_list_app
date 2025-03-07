# frozen_string_literal: true

class TierlistitemsController < ApplicationController
  before_action :set_tierlist
  before_action :set_tierlistitem, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def move
    @tierlistitem = @tierlist.tierlistitems.find(params[:id])
    @tierlistitem.insert_at(params[:position].to_i)
    head :ok
  end

  def new
    @tierlistitem = @tierlist.tierlistitems.build
  end

  def create
    @tierlistitem = @tierlist.tierlistitems.build(tierlistitem_params)
    @tierlistitem.image.attach(params[:tierlistitem][:image])
    if @tierlistitem.save
      flash[:success] = 'Tierlistアイテムが追加されました'
      redirect_to @tierlist
    else
      flash[:error] = 'アイテムの追加に失敗しました'
      render 'tierlists/show'
    end
  end

  def edit; end

  def update
    if @tierlistitem.update(tierlistitem_params)
      flash[:success] = 'Tierlistアイテムが更新されました'
      redirect_to @tierlist
    else
      render 'edit'
    end
  end

  def destroy
    @tierlistitem.destroy
    flash[:success] = 'Tierlistアイテムが削除されました'
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
    params.require(:tierlistitem).permit(:listitem, :rank, :image)
  end

  def correct_user
    return if @tierlist.editable_by_anyone || current_user == @tierlist.user || current_user.admin?

    flash[:error] = '権限がありません'
    redirect_to root_url
  end
end
