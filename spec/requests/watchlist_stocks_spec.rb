require 'rails_helper'

RSpec.describe 'Watchlist Stocks API', type: :request do

  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:watchlist) { create(:watchlist, :with_stocks, user_id: user.id) }
  let!(:portfolio) { create(:portfolio, user_id: user.id) }
  let!(:stocks) { watchlist.stocks }
  let(:user_id) { user.id }
  let(:watchlist_id) { watchlist.id }
  let(:id) { stocks.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /watchlists/:watchlist_id/stocks
  describe "GET /v1/watchlists/:watchlist_id/stocks" do
    before { get "/v1/watchlists/#{watchlist_id}/stocks", params: {}, headers: headers }

    context 'when watchlist exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all watchlist stocks' do
        expect(json.size).to eq(5)
      end
    end

    context 'when watchlist does not exist' do
      let(:watchlist_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Watchlist/)
      end
    end
  end

  # Test suite for GET /watchlists/:watchlist_id/stocks/:id
  describe 'GET /v1/watchlists/:watchlist_id/stocks/:id' do
    before { get "/v1/watchlists/#{watchlist_id}/stocks/#{id}", params: {}, headers: headers }

    context 'when watchlist stock exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the stock' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when watchlist stock does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stock/)
      end
    end
  end

  # Test suite for POST /watchlists/:watchlist_id/stocks
  describe 'POST /v1/watchlists/:watchlist_id/stocks' do
    let(:valid_attributes) {
      { stock: { symbol: 'EXAS', watchlist_id: watchlist_id } }.to_json
    }

    context 'when request attributes are valid' do
      before {
        post "/v1/watchlists/#{watchlist_id}/stocks",
        params: valid_attributes,
        headers: headers
      }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {
        post "/v1/watchlists/#{watchlist_id}/stocks",
        params: { stock: { symbol: '' } }.to_json,
        headers: headers
      }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Symbol can't be blank/)
      end
    end
  end

  # Test suite for PUT /watchlists/:watchlist_id/stocks/:id
  describe 'PUT /v1/watchlists/:watchlist_id/stocks/:id' do
    let(:valid_attributes) {
      { stock: { symbol: 'WDC', watchlist_id: watchlist_id } }.to_json
    }
    before { put "/v1/watchlists/#{watchlist_id}/stocks/#{id}", params: valid_attributes, headers: headers }

    context 'when stock exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the stock' do
        updated_stock = Stock.find(id)
        expect(updated_stock.symbol).to match(/WDC/)
      end
    end

    context 'when moving a stock to the user portfolio' do
      before {
        put "/v1/watchlists/#{watchlist_id}/stocks/#{id}/to_portfolio",
        params: {},
        headers: headers
      }

      it 'updates the stockholder id and type' do
        updated_stock = Stock.find(id)
        expect(updated_stock.stockholder_id).to eq(portfolio.id)
        expect(updated_stock.stockholder_type).to eq("Portfolio")
      end
    end

    context 'when the stock does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stock/)
      end
    end
  end

  # Test suite for DELETE /watchlists/:id
  describe 'DELETE /v1/watchlists/:id' do
    before { delete "/v1/watchlists/#{watchlist_id}/stocks/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
