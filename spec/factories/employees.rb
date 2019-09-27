# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    position { Employee.positions.keys.sample }
  end
end