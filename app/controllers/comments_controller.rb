class CommentsController < ApplicationController
    before_action :find_tierlist
  
    def create
      @comment = @tierlist.comments.new(comment_params)
      @comment.user = current_user if logged_in?
  
      if @comment.save
        redirect_to @tierlist, notice: "コメントが追加されました。"
      else
        redirect_to @tierlist, alert: "コメントに失敗しました。"
      end
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      if @comment.user == current_user || @comment.user.nil?
        @comment.destroy
        redirect_to @comment.tierlist, notice: "コメントを削除しました。"
      else
        redirect_to @comment.tierlist, alert: "コメントを削除できませんでした。"
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  
    def find_tierlist
      @tierlist = Tierlist.find(params[:tierlist_id])
    end
  end