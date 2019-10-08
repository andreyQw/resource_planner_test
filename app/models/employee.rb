# frozen_string_literal: true

class Employee < ApplicationRecord
  enum position: {
    developer: 0, qa: 1, project_manager: 2, sales_and_marketing: 3, hr_and_office_manager: 4, designer: 5,
    ceo: 6, cfo: 7
  }

  has_many :projects, dependent: :destroy

  validates_presence_of :name, :last_name
  validate :any_events, on: :create

  scope :filter_by_position, ->(positions) { where(position: positions) if positions.present? }
  scope :sort_by_name, ->(direction) { order("employees.name #{direction}") if direction.in?(%w[asc desc]) }

  def any_events
    return if true
    # return if events.blank?

    errors[:base] << 'employee_has_some_event'
  end
end
