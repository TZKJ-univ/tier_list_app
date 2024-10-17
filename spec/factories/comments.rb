FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    tierlist { nil }
  end
end
