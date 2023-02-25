# frozen_string_literal: true

module Api
  # Base controller class
  class BaseController < ApplicationController
    def index
      render json: resources, each_serializer: serializer
    end

    def create
      if new_resource.save
        render json: { success: true, data: new_resource }, status: :created
      else
        render json: { success: false, message: new_resource.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if resource.update(permitted_params)
        render json: { success: true, data: resource }
      else
        render json: { success: false, message: resource.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      if resource.destroy
        render json: resource
      else
        render json: { success: false, message: resource.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      render json: resource
    end

    def resources
      @resources ||= model.all
    end

    def resource
      @resource ||= model.find(params[:id])
    end

    def new_resource
      @new_resource ||= model.new(permitted_params)
    end

    def model
      controller_name.camelize.singularize.constantize
    end

    def serializer
      "#{model}Serializer".constantize
    end
  end
end
