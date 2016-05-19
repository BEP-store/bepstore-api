FactoryGirl.define do
  factory :user do
  	sequence(:name) { |n| "User #{n}" }
    sequence(:account_id) { |n| "account_id #{n}" }
  end
end
