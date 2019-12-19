# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    events = Event.all

    render_resources(events)
  end

  def create
    event = Event.create(event_params)

    render_resource_or_errors event
  end

  def show
    event = Event.find(params[:id])

    render_resource event
  end

  def update
    event = Event.find(params[:id])
    event.update(event_params)

    render_resource_or_errors event
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy

    head :ok
  end

  private

  def event_params
    params.permit(:note, :hours_per_day, :date_from, :date_to, :employee_id, :project_id)
  end
end
