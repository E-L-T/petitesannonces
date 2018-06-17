# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content 'Great !'
    user_id 1
    advertisement_id 1
  end
end
