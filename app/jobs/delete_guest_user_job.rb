# app/jobs/delete_guest_user_job.rb
class DeleteGuestUserJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    user.destroy if user && user.guest? # ゲストユーザーであるか確認して削除
  end
end
