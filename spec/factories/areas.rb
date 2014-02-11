require 'faker'

FactoryGirl.define do
  factory :area do
    name Faker::Address.city.to_s
    code Faker::Number.number(6).to_i
    state Faker::Address.state_abbr.to_s
  end
end