# app/jobs/delete_guest_user_job.rb
class DeleteGuestUserJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      if user.guest? && user.tierlists.empty?
        user.destroy
      end
    end
  end
end