# frozen_string_literal: true

module Api
  # Spots controller class
  class SpotsController < BaseController
    def index
      render json: resources.includes(:reviews), each_serializer: serializer
    end

    private

    def permitted_params
      params.require(:spot).permit(:title, :description, :price, images: [])
    end
  end
end
