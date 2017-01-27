FactoryGirl.define do
  factory :story do
    title "MyString"
    association :team, factory: :team, strategy: :build
  end
end
