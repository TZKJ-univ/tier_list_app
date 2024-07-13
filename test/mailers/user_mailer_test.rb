require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'account_activation' do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal 'アカウント有効化', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['tierlistgstonehill@gmail.com'], mail.from

    # テキスト部分のメール本文をチェック
    text_body = mail.text_part.body.decoded
    assert_match user.name, text_body
    assert_match user.activation_token, text_body
    assert_match CGI.escape(user.email), text_body

    # HTML部分のメール本文をチェック
    html_body = mail.html_part.body.decoded
    assert_match user.name, html_body
    assert_match user.activation_token, html_body
    assert_match CGI.escape(user.email), html_body
  end

  test 'password_reset' do
    user = users(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal 'パスワードリセット', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['tierlistgstonehill@gmail.com'], mail.from

    # テキスト部分のメール本文をチェック
    text_body = mail.text_part.body.decoded
    assert_match user.reset_token, text_body
    assert_match CGI.escape(user.email), text_body

    # HTML部分のメール本文をチェック
    html_body = mail.html_part.body.decoded
    assert_match user.reset_token, html_body
    assert_match CGI.escape(user.email), html_body
  end
end
