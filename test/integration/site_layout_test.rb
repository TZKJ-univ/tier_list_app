require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    get contact_path
    assert_select "title", full_title("Contact")
  end

  test "layout links with logged in" do
    log_in_as(@user)
    get root_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    assert_match @user.followers.count.to_s, response.body
    assert_match @user.following.count.to_s, response.body
  end
  test "Signup Path layout links" do
    get signup_path
    assert_template 'users/new'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", contact_path
    assert_select "title", full_title("Sign up")
  end
end
