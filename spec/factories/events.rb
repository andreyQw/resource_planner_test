# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    project
    employee
    note { FFaker::Lorem.phrase }
    hours_per_day { rand(1..8) }
    date_from { DateTime.current }
    date_to { DateTime.current + rand(1..30).days }
  end
end
