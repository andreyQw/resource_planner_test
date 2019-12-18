# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:params) { {} }

  describe 'GET #index' do
    let(:employee_attr_types) do
      {
        id: :int,
        name: :string,
        last_name: :string,
        position: :string
      }
    end
    let!(:employee1) { create :employee, name: 'abc', position: 'developer' }
    let!(:employee2) { create :employee, name: 'bcd', position: 'qa' }

    subject { get :index, params: params }

    it 'returns http success' do
      subject
      expect_status 200
      expect_json_sizes(resources: 2)
      expect_json_types('resources.*', employee_attr_types)
      expect_json('meta', total: 2)
    end

    context 'filter' do
      let(:params) { {positions: :developer} }

      it 'by positions' do
        subject
        expect_status 200
        expect_json_sizes(resources: 1)
        expect_json_types('resources.*', employee_attr_types)
        expect_json('resources.0', id: employee1.id)
      end
    end

    context 'sort' do
      let(:params) { {direction: :desc} }

      it 'by :desc' do
        subject
        expect_status 200
        expect(json_response[:resources].map { |e| e[:name] }).to contain_exactly(employee2.name, employee1.name)
      end
    end
  end

  describe 'POST #create' do
    let(:params) { {name: 'Bob', last_name: 'Bond', position: 'developer'} }
    subject { post :create, params: params }

    it 'success' do
      subject
      expect_status 200
      expect_json('resource', params)
    end

    context 'with empty filds' do
      let(:params) { {name: ' ', last_name: ' ', position: 'developer'} }

      it 'errors' do
        subject
        expect_status 422
        expect_json('errors', name: ['can\'t be blank'], last_name: ['can\'t be blank'])
      end
    end
  end

  describe 'GET #show' do
    let(:employee) { create :employee }
    let(:employee_params) { {id: employee.id} }
    subject { get :show, params: employee_params }

    it 'success' do
      subject
      expect_status 200
      expect_json('resource.id', employee.id)
    end

    context 'wrong id' do
      let(:employee_params) { {id: employee.id + 1} }

      it 'errors' do
        subject
        expect_status 404
      end
    end
  end

  describe 'PUT #update' do
    let!(:employee) { create :employee, position: 'qa' }
    let(:resource_params) { {name: 'Bob', last_name: 'Bond', position: 'developer'} }
    let(:params) { resource_params.merge(id: employee.id) }

    subject { put :update, params: params }

    it 'success' do
      subject
      expect_status 200
      expect_json('resource', params)
    end
  end

  describe 'DELETE #destroy' do
    let!(:employee) { create :employee }
    let(:params) { {id: employee.id} }
    subject { delete :destroy, params: params }

    it 'success' do
      expect { subject }.to change(Employee, :count).by(-1)
      expect_status 200
    end
  end
end
