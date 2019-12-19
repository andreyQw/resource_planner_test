# frozen_string_literal: true

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :color

  belongs_to :employee, serializer: EmployeeSerializer
end
