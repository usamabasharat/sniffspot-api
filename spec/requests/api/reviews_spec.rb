# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Reviews', type: :request do
  describe '#create' do
    let(:params) { { review: { comment: 'Great', rating: 3 } } }

    before do
      spot = Spot.new(title: 'Test spot', description: 'Description', price: 10)
      spot.images.attach(io: File.open(Rails.root.join('spec/support/assets/night_city.jpg')),
                         filename: 'attachment.jpg', content_type: 'image/jpg')
      spot.save!
    end

    context 'when correct params are passed' do
      it 'successfully creates a review against a spot' do
        post api_spot_reviews_path(Spot.last.id, params)

        expect(response).to have_http_status(:success)
        expect(Spot.last.reviews.size).to eq(1)
      end
    end

    context 'when incorrect params are passed' do
      it 'returns error response' do
        params[:review][:rating] = 8

        post api_spot_reviews_path(Spot.last.id, params)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message']).to eq(['Rating must be less than or equal to 5'])
      end
    end
  end

  describe '#update' do
    before do
      spot = Spot.new(title: 'Test spot', description: 'Description', price: 10)
      spot.images.attach(io: File.open(Rails.root.join('spec/support/assets/night_city.jpg')),
                         filename: 'attachment.jpg', content_type: 'image/jpg')
      spot.save!

      spot.reviews.create!(comment: 'A dummy comment', rating: 2)
    end

    context 'when correct params are given' do
      it 'successfully updates the review' do
        put api_review_path(Spot.last.reviews.first.id, { review: { comment: 'Updated comment', rating: 4 } })

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['success']).to eq(true)
      end
    end

    context 'when incorrect params are passed' do
      it 'returns error response' do
        put api_review_path(Spot.last.reviews.first.id, { review: { comment: 'Updated comment', rating: -10 } })

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['success']).to eq(false)
      end
    end
  end
end
