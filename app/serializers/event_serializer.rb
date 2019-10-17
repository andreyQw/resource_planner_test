# frozen_string_literal: true

class EventSerializer < ActiveModel::Serializer
  attributes :id, :note, :hours_per_day, :date_from, :date_to

  belongs_to :project, serializer: ProjectSerializer
  belongs_to :employee, serializer: EmployeeSerializer
end