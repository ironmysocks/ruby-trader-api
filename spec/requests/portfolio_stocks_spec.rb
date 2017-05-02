require 'rails_helper'

RSpec.describe 'Portfolio Stocks API', type: :request do

  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:portfolio) { create(:portfolio, :with_stocks, user_id: user.id) }
  let!(:stocks) { portfolio.stocks }
  let(:user_id) { user.id }
  let(:portfolio_id) { portfolio.id }
  let(:id) { stocks.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /portfolios/:portfolio_id/stocks
  describe "GET /v1/portfolios/:portfolio_id/stocks" do
    before { get "/v1/portfolios/#{portfolio_id}/stocks", params: {}, headers: headers }

    context 'when portfolio exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all portfolio stocks' do
        expect(json.size).to eq(5)
      end
    end

    context 'when portfolio does not exist' do
      let(:portfolio_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Portfolio/)
      end
    end
  end

  # Test suite for GET /portfolios/:portfolio_id/stocks/:id
  describe 'GET /v1/portfolios/:portfolio_id/stocks/:id' do
    before { get "/v1/portfolios/#{portfolio_id}/stocks/#{id}", params: {}, headers: headers }

    context 'when portfolio stock exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the stock' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when portfolio stock does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stock/)
      end
    end
  end

  # Test suite for POST /portfolios/:portfolio_id/stocks
  describe 'POST /v1/portfolios/:portfolio_id/stocks' do
    let(:valid_attributes) {
      { stock: { symbol: 'EXAS', portfolio_id: portfolio_id } }.to_json
    }

    context 'when request attributes are valid' do
      before {
        post "/v1/portfolios/#{portfolio_id}/stocks",
        params: valid_attributes,
        headers: headers
      }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {
        post "/v1/portfolios/#{portfolio_id}/stocks",
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

  # Test suite for PUT /portfolios/:portfolio_id/stocks/:id
  describe 'PUT /v1/portfolios/:portfolio_id/stocks/:id' do
    let(:valid_attributes) {
      { stock: { symbol: 'WDC', portfolio_id: portfolio_id } }.to_json
    }
    before { put "/v1/portfolios/#{portfolio_id}/stocks/#{id}", params: valid_attributes, headers: headers }

    context 'when stock exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the stock' do
        updated_stock = Stock.find(id)
        expect(updated_stock.symbol).to match(/WDC/)
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

  # Test suite for DELETE /portfolios/:id
  describe 'DELETE /v1/portfolios/:id' do
    before { delete "/v1/portfolios/#{portfolio_id}/stocks/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

=begin
  context "Portfolios" do
     include_examples "has nested stocks"
  end

  context "Portfolios" do
     include_examples "has nested stocks" do
       let(:stockholder) { create(:stocks) }
     end
  end
=end

end
