# frozen_string_literal: true

FactoryBot.define do
  factory :tierlistitem do
    sequence(:listitem) { |n| "Tierlistitem #{n}" }
    rank { 1 }
    association :tierlist
  end
end
