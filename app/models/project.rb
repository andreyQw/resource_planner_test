# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :employee

  validates_presence_of :name

  scope :filter_by_employee, ->(employee_id) { where(employee_id: employee_id) if employee_id.present? }
  scope :sort_by_name, ->(direction) { order("projects.name #{direction}") if direction.in?(%w[asc desc]) }
end
