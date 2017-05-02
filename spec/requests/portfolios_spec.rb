require 'rails_helper'

RSpec.describe 'Portfolio API', type: :request do

  # initialize test data
  let!(:user) { create(:user) }
  let!(:portfolios) { create_list(:portfolio, 5, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { portfolios.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /portfolios
  describe 'GET /v1/portfolios' do
    # make HTTP get request before each example
    before { get '/v1/portfolios', params: {}, headers: headers }

    it 'returns portfolios' do
      # Note `json` is a custom helper to parse JSON responses
      p json
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  # Test suite for GET /portfolios/:id
  describe 'GET /v1/portfolios/:id' do
    before { get "/v1/portfolios/#{id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the portfolio' do
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
        expect(response.body).to match(/Couldn't find Portfolio with 'id'=#{id}/)
      end
    end
  end

  # Test suite for POST /portfolios
  describe 'POST /v1/portfolios' do
    # valid payload
    let(:valid_attributes) {
      { portfolio: { user_id: user_id } }.to_json
    }

    context 'when the request is valid' do
      before { post '/v1/portfolios', params: valid_attributes, headers: headers }

      it 'creates a portfolio' do
        expect(json['user_id']).to eq(user_id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

    end

    context 'when the request is invalid' do
      before {
        post '/v1/portfolios',
        params: { portfolio: { name: 'Foobar' } }.to_json,
        headers: headers
      }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: User must exist, User can't be blank/)
      end
    end
  end

  # Test suite for PUT /portfolios/:id
  describe 'PUT /v1/portfolios/:id' do
    let(:valid_attributes) {
      { portfolio: { user_id: '1' } }.to_json
    }

    context 'when the record exists' do
      before { put "/v1/portfolios/#{id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

    end
  end

  # Test suite for DELETE /portfolios/:id
  describe 'DELETE /v1/portfolios/:id' do
    before { delete "/v1/portfolios/#{id}", params: {}, headers: headers }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
