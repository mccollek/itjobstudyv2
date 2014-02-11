require 'faker'

FactoryGirl.define do
  factory :occupation do
    name Faker::Lorem.words(num = 3).to_s
    code Faker::Number.number(6).to_i
  end
end