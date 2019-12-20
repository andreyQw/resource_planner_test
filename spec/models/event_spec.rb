# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to :project }
  it { is_expected.to belong_to :employee }

  it { is_expected.to have_db_column(:note).of_type(:text) }
  it { is_expected.to have_db_column(:hours_per_day).of_type(:integer) }
  it { is_expected.to have_db_column(:date_from).of_type(:datetime) }
  it { is_expected.to have_db_column(:date_to).of_type(:datetime) }
  it { is_expected.to have_db_column(:leave_type).of_type(:integer) }

  it { is_expected.to validate_presence_of :date_from }
  it { is_expected.to validate_presence_of :date_to }
  it { validate_inclusion_of(:hours_per_day).in_range(1..24) }

  it { is_expected.to validate_presence_of(:project_id) }
  describe '#project' do
    context 'leave_type is not a free' do
      before { allow(subject).to receive(:free?).and_return(false) }
      it { is_expected.not_to validate_presence_of(:project_id) }
    end
  end
end
