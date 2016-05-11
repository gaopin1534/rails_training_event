# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    hold_at "2016-05-11 14:54:54"
    capacity 1
    location "MyString"
    owner 1
    description "MyText"
  end
end
