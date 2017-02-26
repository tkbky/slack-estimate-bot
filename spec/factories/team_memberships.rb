FactoryGirl.define do
  factory :team_membership do
    association :user, factory: :user, strategy: :build
    association :team, factory: :team, strategy: :build

    trait :invalid do
      user nil
      team nil
    end
  end
end
