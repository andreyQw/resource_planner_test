# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  it { is_expected.to have_db_column(:name).of_type(:string) }
  it { is_expected.to have_db_column(:last_name).of_type(:string) }
  it { is_expected.to have_db_column(:position).of_type(:integer) }
  it { is_expected.to have_many :projects }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :last_name }
end
