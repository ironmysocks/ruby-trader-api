require 'rails_helper'

RSpec.describe 'Watchlists API', type: :request do

  # initialize test data
  let!(:user) { create(:user) }
  let!(:watchlists) { create_list(:watchlist, 10, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { watchlists.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /watchlists
  describe 'GET /v1/watchlists' do
    # make HTTP get request before each example
    before { get '/v1/watchlists', params: {}, headers: headers  }

    it 'returns watchlists' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200'do
      expect(response).to have_http_status(200)
    end

  end

  # Test suite for GET /watchlists/:id
  describe 'GET /v1/watchlists/:id' do
    before { get "/v1/watchlists/#{id}", params: {}, headers: headers  }

    context 'when the record exists' do
      it 'returns the watchlist' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Watchlist with 'id'=#{id}/)
      end
    end
  end

  # Test suite for POST /watchlists
  describe 'POST /v1/watchlists' do
    # valid payload
    let(:valid_attributes) {
      { watchlist: { user_id: user_id, name: 'Coolio' } }.to_json
    }

    context 'when the request is valid' do
      before { post '/v1/watchlists', params: valid_attributes, headers: headers }

      it 'creates a watchlist' do
        expect(json['name']).to eq('Coolio')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {
        post '/v1/watchlists',
        params: { watchlist: { password: '' } }.to_json,
        headers: headers
      }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /watchlists/:id
  describe 'PUT /v1/watchlists/:id' do
    let(:valid_attributes) {
      { watchlist: { name: 'Cool beans lists' } }.to_json
    }

    context 'when the record exists' do
      before { put "/v1/watchlists/#{id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /watchlists/:id
  describe 'DELETE /v1/watchlists/:id' do
    before { delete "/v1/watchlists/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
