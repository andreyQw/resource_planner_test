# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :employee

  validates_presence_of :name, :color
  validate :any_events, on: :destroy

  scope :filter_by_employee, ->(employee_id) { where(employee_id: employee_id) if employee_id.present? }
  scope :sort_by_name, ->(direction) { order("projects.name #{direction}") if direction.in?(%w[asc desc]) }

  def any_events
    # TODO: Project- implement in future. When events will be present
    return if true
    # return if events.blank?

    # errors.add(:events, 'You can not delete the employee, with events')
  end
end
