# frozen_string_literal: true

FactoryBot.define do
  factory :advertisement do
    title 'Comics collection'
    content '48 albums'
    price '100 euros'
    state 'published'
    user_id 1
  end
end
