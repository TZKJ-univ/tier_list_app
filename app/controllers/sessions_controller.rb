class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        log_in(@user)
        redirect_to forwarding_url || new_tierlist_path, status: :see_other
      else
        message = 'Account not activated!'
        message += 'Check your email for the activation link.'
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end

  def create_guest
    user = User.create_guest_user
    if user.persisted?
      session[:user_id] = user.id
      session[:session_token] = user.session_token
      redirect_to new_tierlist_path, notice: 'ゲストユーザーとしてログインしました。'
    else
      redirect_to root_path, alert: 'ゲストユーザーの作成に失敗しました。'
    end
  end
end
