# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
    nickname "MyString"
    description "MyText"
    image "MyString"
    uid 1
  end
end
