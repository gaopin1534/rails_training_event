FactoryGirl.define do
  factory :absented do
    association :user
    association :event
  end
end
