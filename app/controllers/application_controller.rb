# frozen_string_literal: true

# Application controller class
class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render json: { success: false, message: 'Record not found' }, status: 404
  end
end
