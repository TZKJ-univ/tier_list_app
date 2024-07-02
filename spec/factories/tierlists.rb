FactoryBot.define do
  factory :tierlist do
    list { "Tierlist 1" }
    association :user    
  end
end
