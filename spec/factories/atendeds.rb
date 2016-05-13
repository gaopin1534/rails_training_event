FactoryGirl.define do
  factory :atended do
    association :user
    association :event
    status 'attended'
  end
end
