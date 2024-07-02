FactoryBot.define do
  factory :tierlistitem do
    listitem { "Tierlistitem 1" }
    rank { 1 }
    association :tierlist
  end
end
