# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:params) { {} }

  describe 'GET #index' do
    let(:event_attr_types) do
      {
        id: :int,
        note: :string,
        hours_per_day: :integer,
        date_from: :string,
        date_to: :string,
        employee: :object,
        project: :object
      }
    end
    let!(:event) { create :event }

    subject { get :index, params: params }

    it 'returns success' do
      subject

      expect_status 200
      expect_json_sizes(resources: 1)
      expect_json_types('resources.*', event_attr_types)
      expect_json('meta', total: 1)
    end
  end

  describe 'POST #create' do
    let!(:employee) { create :employee }
    let!(:project) { create :project }
    let(:params) do
      {
        note: 'Event A',
        hours_per_day: 8,
        date_from: DateTime.current,
        date_to: (DateTime.current + 9.days),
        employee_id: employee.id,
        project_id: project.id
      }
    end
    subject { post :create, params: params }

    it 'success' do
      subject
      expect_status 200
      expect_json('resource', params.slice('employee_id', 'project_id'))
    end
  end

  describe 'GET #show' do
    let!(:event) { create :event }
    subject { get :show, params: {id: event.id} }

    it 'success' do
      subject
      expect_status 200
      expect_json('resource.id', event.id)
    end
  end

  describe 'PUT #update' do
    let!(:event) { create :event }
    let(:resource_params) { {note: 'New note'} }
    let(:params) { resource_params.merge(id: event.id) }

    subject { put :update, params: params }

    it 'success' do
      subject
      expect_status 200
      expect_json('resource', params)
    end
  end

  describe 'DELETE #destroy' do
    let!(:event) { create :event }
    subject { delete :destroy, params: {id: event.id} }

    it 'success' do
      expect { subject }.to change(Event, :count).by(-1)
      expect_status 200
    end
  end
end
