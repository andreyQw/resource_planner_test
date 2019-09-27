# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_resources(resources, options = {}) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    pagination = options[:pagination].nil? || options.delete(:pagination)

    meta = {}

    if pagination
      resources = resources.page(params[:page]).per(params[:per_page]).padding(params[:padding])

      if options.dig(:meta, :total).blank?
        meta[:total] =
          if resources.respond_to?(:unscope)
            resources.unscope(:limit, :order, :offset).count(:id)
          else
            resources.length
          end
      end
    end

    options.delete(:before_render).call(resources) if options.key?(:before_render)

    render({
      json: resources, meta: meta
    }.deep_merge(options))
  end

  def render_resource(resource, options = {})
    render(json: resource, **options)
  end

  def render_errors(resource)
    render(json: {errors: resource.errors}, status: :unprocessable_entity)
  end

  def render_resource_or_errors(resource, options = {})
    resource.try(:errors).present? ? render_errors(resource) : render_resource(resource, options)
  end

  rescue_from ActiveRecord::RecordNotFound do
    render json: {error: 'record_not_found'}, status: :not_found
  end
end
