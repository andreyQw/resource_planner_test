# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :project
  belongs_to :employee

  validates_presence_of :project_id, if: :free?
  validates_presence_of :date_from, :date_to
  validates_inclusion_of :hours_per_day, in: 1..24

  enum leave_type: {free: 0, vacation: 1, sick: 2, unpaid_leave: 3}
end
