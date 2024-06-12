module SessionsHelper

    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end

    def log_in(user)
        session[:user_id] = user.id
        #セッションリプレイ攻撃に対する保護
        session[:session_token] = user.session_token
    end

    def remember(user)
        user.remember #user.remember_tokenをuser.new_tokenによって作り、remember_digestに保存する
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    #記憶トークンのcookieに対応するユーザを返す
    def current_user 
        if (user_id = session[:user_id])
            user = User.find_by(id: user_id)
            if user && session[:session_token] == user.session_token
                @current_user = user
            end
        elsif (user_id = cookies.encrypted[:user_id])
            user = User.find_by(id: cookies.encrypted[:user_id])
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    def logged_in?
        !current_user.nil?
    end

    def forget(user)
        user.forget #remember_digesrtをnilにする
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def log_out
        forget(current_user)
        reset_session
        @current_user = nil #念の為
    end

    #渡されたユーザーがカレントユーザーか審査
    def current_user?(user)
        user && user == current_user
    end

end
