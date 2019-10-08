# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    employee
    name { FFaker::Lorem.word }
    color { FFaker::Color.hex_code }
  end
end
