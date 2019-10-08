# frozen_string_literal: true

class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_name, :position
end
