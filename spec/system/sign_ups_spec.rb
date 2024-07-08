require 'rails_helper'

RSpec.describe "SignUps", type: :system do
  include ActiveJob::TestHelper

  it "user creates a new account" do
    visit signup_path

    perform_enqueued_jobs do
      fill_in "アカウントネーム", with: "Example User"
      fill_in "Email", with: "test@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード確認", with: "password"
      click_button "アカウント作成"
    end

    # 期待されるユーザー数の増加を確認
    expect(User.count).to eq(1)

    # メールがキューに追加されていることを確認
    mail = ActionMailer::Base.deliveries.last

    aggregate_failures do
      expect(mail).not_to be_nil
      expect(mail.to).to eq ["test@example.com"]
      expect(mail.from).to eq ["tierlistgstonehill@gmail.com"]
      expect(mail.subject).to eq "アカウント有効化"
    end
  end
end
