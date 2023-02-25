# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::SpotsController', type: :request do
  describe '#index' do
    before do
      spot = Spot.new(title: 'Test spot', description: 'Description', price: 10)
      spot.images.attach(io: File.open(Rails.root.join('spec/support/assets/night_city.jpg')),
                         filename: 'attachment.jpg', content_type: 'image/jpg')
      spot.save!

      get api_spots_path
    end

    it 'returns success response with spots' do
      expect(response).to have_http_status(:success)
    end

    it 'returns spots data in response' do
      parsed_response = JSON.parse(response.body)

      expect(parsed_response).to eq([SpotSerializer.new(Spot.last).attributes.as_json])
    end
  end

  describe '#create' do
    let(:params) do
      {
        spot: {
          title: 'Dummy',
          description: 'Test description',
          price: 100
        }
      }
    end

    context 'when params are valid' do
      it 'successfully creates a new response' do
        post api_spots_path(params)

        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(parsed_response['success']).to eq(true)
      end
    end

    context 'when params are invalid' do
      it 'returns error in response' do
        params[:spot][:title] = ''

        post api_spots_path(params)
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['success']).to eq(false)
        expect(parsed_response['message']).to eq(['Title can\'t be blank'])
      end
    end
  end

  describe '#update' do
    let(:params) do
      {
        spot: {
          title: 'Updated title',
          description: 'Updated description',
          price: 150
        }
      }
    end

    before do
      spot = Spot.new(title: 'Test spot', description: 'Description', price: 10)
      spot.images.attach(io: File.open(Rails.root.join('spec/support/assets/night_city.jpg')),
                         filename: 'attachment.jpg', content_type: 'image/jpg')
      spot.save!
    end

    context 'when correct spot id is passed' do
      it 'successfully updates the spot' do
        patch api_spot_path(Spot.last.id, params)

        expect(response).to have_http_status(:success)
        expect(Spot.last.title).to eq('Updated title')
        expect(Spot.last.description).to eq('Updated description')
        expect(Spot.last.price).to eq(150)
      end
    end

    context 'when incorrect spot id is passed' do
      it 'returns record not found response' do
        patch api_spot_path(0, params)

        expect(response).to have_http_status(404)
        expect(JSON.parse(response.body)['success']).to eq(false)
      end
    end
  end
end
