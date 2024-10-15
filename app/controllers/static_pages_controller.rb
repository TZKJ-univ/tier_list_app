# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @tierlist = current_user.tierlists.build
    @feed_items = current_user.feed.paginate(page: params[:page])
    @tierlist_feed_items = current_user.tierlist_feed.paginate(page: params[:page])
  end

  def help; end

  def about; end

  def contact; end
end
