FactoryGirl.define do
  factory :estimate do
    uuid { SecureRandom.uuid }
    point 0
    status 'pending'
    association :story, factory: :story, strategy: :build
    user_slack_id { SecureRandom.hex }

    trait :with_point do
      point 1
    end

    trait :invalid do
      uuid ''
      point -1
      story nil
      user_slack_id ''
      status ''
    end
  end
end
