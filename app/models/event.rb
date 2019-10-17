# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :project
  belongs_to :employee
end
