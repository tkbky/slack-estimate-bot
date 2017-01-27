FactoryGirl.define do
  factory :team do
    slack_id "MyString"
    name "MyString"
    incoming_webhook_url "MyString"
    incoming_webhook_channel "MyString"
    incoming_webhook_config_url "MyString"
    bot_user_id "MyString"
    bot_access_token "MyString"
    access_token "MyString"
    scope "MyString"

    trait :invalid do
      slack_id ''
      name ''
      incoming_webhook_url ''
      incoming_webhook_channel ''
      incoming_webhook_config_url ''
      access_token ''
      scope ''
    end
  end
end
