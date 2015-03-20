require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :question do
    title {Faker::Lorem.word}
    content {Faker::Lorem.sentence}
  end

  factory :answer do
    title {Faker::Lorem.word}
    content {Faker::Lorem.sentence}
  end
end


