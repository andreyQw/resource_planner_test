# frozen_string_literal: true

class EmployeesController < ApplicationController
  def index
    employees = Employee.filter_by_position(params[:positions]).sort_by_name(params[:direction])

    render_resources(employees)
  end

  def create
    employee = Employee.create(employee_params)

    render_resource_or_errors employee
  end

  def show
    employee = Employee.find(params[:id])

    render_resource employee
  end

  def update
    employee = Employee.find(params[:id])
    employee.update(employee_params)

    render_resource_or_errors employee
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy

    head :ok
  end

  private

  def employee_params
    params.permit(:name, :last_name, :position)
  end
end
