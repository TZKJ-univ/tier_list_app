# frozen_string_literal: true

# app/jobs/delete_guest_user_job.rb
class DeleteGuestUserJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      user.destroy if user.guest? && user.tierlists.empty?
    end
  end
end
