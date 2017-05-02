require 'rails_helper'

RSpec.describe 'Watchlist User API', type: :request do

  # initialize test data
  let(:headers) { valid_headers }
  let!(:user) { create(:user, :with_watchlists) }
  let(:id) { user.id }

  # Test suite for GET /v1/watchlists/user/:id
  describe 'GET /v1/watchlists/user/:id' do
    before { get "/v1/watchlists/user/#{id}", params: {}, headers: headers }

    context 'when the user exists' do
      it 'returns the watchlist' do
        expect(json).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end

    context 'when the user does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Watchlist\"}")
      end
    end
  end
  
end
