# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name 'Estelle'
    password 'password'

    trait :administrateur do
      role 'admin'
    end
  end
end
