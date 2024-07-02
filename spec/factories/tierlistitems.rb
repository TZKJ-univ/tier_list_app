FactoryBot.define do
  factory :tierlistitem do
    sequence(:listitem) { |n| "Tierlistitem #{n}" }
    rank { 1 }
    association :tierlist
  end
end
