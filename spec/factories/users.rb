FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user.#{i}@test.com" }
    sequence(:name) { |i| "user.#{i}" }
    sequence(:slack_id) { |i| "slack.id.#{i}" }

    trait :invalid do
      email ''
      name ''
      slack_id ''
    end
  end
end
