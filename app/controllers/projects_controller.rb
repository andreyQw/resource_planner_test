# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    projects = Project.all.filter_by_employee(params[:employee_id]).sort_by_name(params[:direction])

    render_resources(projects)
  end

  def create
    project = Project.create(project_params)

    render_resource_or_errors project
  end

  def show
    project = Project.find(params[:id])

    render_resource project
  end

  def update
    project = Project.find(params[:id])
    project.update(project_params)

    render_resource_or_errors project
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy

    head :ok
  end

  private

  def project_params
    params.permit(:name, :color, :position, :employee_id)
  end
end
