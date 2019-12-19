# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to :project }
  it { is_expected.to belong_to :employee }

  it { is_expected.to have_db_column(:note).of_type(:text) }
  it { is_expected.to have_db_column(:hours_per_day).of_type(:integer) }
  it { is_expected.to have_db_column(:date_from).of_type(:datetime) }
  it { is_expected.to have_db_column(:date_to).of_type(:datetime) }
end
