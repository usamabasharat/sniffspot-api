# frozen_string_literal: true

module Api
  # Reviews controller class
  class ReviewsController < BaseController
    before_action :set_spot, only: [:create]

    private

    def permitted_params
      params.require(:review).permit(:rating, :comment)
    end

    def new_resource
      @new_resource ||= @spot.reviews.new(permitted_params)
    end

    def set_spot
      @spot = Spot.find(params[:spot_id])
    end
  end
end
