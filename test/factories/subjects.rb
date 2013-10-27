# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subject do
    title "MyString"
    description "MyText"
    active false
    position 1
    parent 1
  end
end
