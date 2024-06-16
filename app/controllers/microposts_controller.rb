class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @micropost = current_user.microposts.build(micropost_params)
        @micropost.image.attach(params[:micropost][:image])
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed.paginate(page: params[:page])
            render 'static_pages/home', status: :unprocessable_entity
        end
    end

    def destroy
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        flash[:succsess] = "micropost deleted"
        if request.referrer.nil?
            redirect_back_or_to(root_url, status: :see_other)
        else
            redirect_back_or_to(root_url, status: :see_other)
        end
        # リファラーが空になるケース(ブックマークなどにdestroyのURLを保存していた場合や
        # シークレットモードによる場合などリファラーがnilになるケースは割とありそう)
    end

    private

        def micropost_params
            params.require(:micropost).permit(:content, :image)
        end

        def correct_user
            @micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_url, status: :see_other if @micropost.nil?
        end
end
