# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  it { is_expected.to have_db_column(:name).of_type(:string) }
  it { is_expected.to have_db_column(:color).of_type(:string) }
  it { is_expected.to belong_to :employee }

  it { is_expected.to validate_presence_of :name }
end
