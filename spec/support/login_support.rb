module LoginSupport
  def log_in(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
