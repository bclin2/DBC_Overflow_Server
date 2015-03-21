require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :question do |f|
    f.title {Faker::Lorem.word}
    f.content {Faker::Lorem.sentence}

    factory :question_with_answer do
      after(:create) do |question|
        create(:answer, question: question)
      end
    end
  end

  factory :answer do
    title {Faker::Lorem.word}
    content {Faker::Lorem.sentence}
  end
end


