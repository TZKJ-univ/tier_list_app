require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'account_activation' do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.account_activation(user) }

    it 'sends a account_activate email' do
      expect(mail.subject).to eq('アカウント有効化')
      expect(mail.to).to eq([user.email])
    end

    it 'send from correct email' do
      expect(mail.from).to eq ['tierlistgstonehill@gmail.com']
    end
  end
end
