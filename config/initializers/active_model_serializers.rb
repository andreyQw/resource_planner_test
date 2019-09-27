# frozen_string_literal: true

ActiveModelSerializers.config.adapter = :json
# ActiveModelSerializers.config.adapter = :json_api

ActiveModelSerializers.config.default_includes = '**'

ActiveSupport::Cache::Store.logger = Rails.logger # seems to be the best way
