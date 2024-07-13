# spec/support/session_helpers.rb
module SessionHelpers
  def log_in_as(user)
    post login_path, params: { session: { email: user.email, password: 'password' } }
  end

  def log_out
    delete logout_path
  end
end
