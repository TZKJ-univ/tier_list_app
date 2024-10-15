# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'アカウント有効化'
    Rails.logger.info 'Text part of the email:'
    Rails.logger.info mail.text_part.body.decoded

    # HTML部分のメール本文をログに出力
    Rails.logger.info 'HTML part of the email:'
    Rails.logger.info mail.html_part.body.decoded

    mail
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'パスワードリセット'
  end
end
