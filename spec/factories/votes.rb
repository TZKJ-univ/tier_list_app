# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    tierlistitem { nil }
    vote_type { 1 }
  end
end
