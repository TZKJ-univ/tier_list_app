class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @tierlist = current_user.tierlists.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @tierlist_feed_items = current_user.tierlist_feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
