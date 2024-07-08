FactoryBot.define do
  factory :tierlist do
    sequence(:list) { |n| "Tierlist Test #{n}" }
    created_at { Time.zone.now }
    association :user

    trait :created_yesterday do
      created_at { Time.zone.now - 1.day }
    end

    trait :created_tommorow do
      created_at { Time.zone.now + 1.day }
    end

    trait :with_tierlistitems do
      after(:create) { |tierlist| create_list(:tierlistitem, 3, tierlist: tierlist) }
    end

    trait :invalid do
      list { nil }
    end
  end
end
