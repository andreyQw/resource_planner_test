# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:params) { {} }

  describe 'GET #index' do
    let(:project_attr_types) do
      {
        id: :int,
        name: :string,
        color: :string,
        employee: :object
      }
    end
    let!(:project1) { create :project, name: 'abc' }

    subject { get :index, params: params }

    it 'returns http success' do
      subject
      expect_status 200
      expect_json_sizes(resources: 1)
      expect_json_types('resources.*', project_attr_types)
      expect_json('meta', total: 1)
    end

    context 'filter' do
      let!(:employee) { create :employee }
      let!(:project2) { create :project, employee: employee }

      let(:params) { {employee_id: employee.id} }

      it 'by positions' do
        subject
        expect_status 200
        expect_json_sizes(resources: 1)
        expect_json('resources.0', id: project2.id)
      end
    end

    context 'sort' do
      let!(:project2) { create :project, name: 'bcd' }
      let(:params) { {direction: :desc} }

      it 'by :desc' do
        subject
        expect_status 200
        expect(json_response[:resources].map { |e| e[:name] }).to contain_exactly(project2.name, project1.name)
      end
    end
  end

  describe 'POST #create' do
    let!(:employee) { create :employee }
    let(:params) { {name: 'Resource Planer', color: 'FF0000', employee_id: employee.id} }
    subject { post :create, params: params }

    it 'success' do
      subject
      expect_status 200
      expect_json('resource', params.slice('name', 'color'))
    end
  end

  describe 'GET #show' do
    let!(:project) { create :project }
    subject { get :show, params: {id: project.id} }

    it 'success' do
      subject
      expect_status 200
      expect_json('resource.id', project.id)
    end
  end

  describe 'PUT #update' do
    let!(:project) { create :project }
    let(:resource_params) { {name: 'Startup', color: 'FF0000'} }
    let(:params) { resource_params.merge(id: project.id) }

    subject { put :update, params: params }

    it 'success' do
      subject
      expect_status 200
      expect_json('resource', params)
    end
  end

  describe 'DELETE #destroy' do
    let!(:project) { create :project }
    subject { delete :destroy, params: {id: project.id} }

    it 'success' do
      expect { subject }.to change(Project, :count).by(-1)
      expect_status 200
    end
  end
end
