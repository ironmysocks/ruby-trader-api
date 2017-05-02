require 'rails_helper'

RSpec.describe 'Users API' do
    let(:user) { build(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_attributes) {
      {
        "first_name": "Test",
        "last_name": "User",
        "email": "testuser@test.com",
        "password": "testtest",
        "password_confirmation": "testtest"
      }
    }

    # User signup test suite
    describe 'POST /v1/signup' do
      context 'when valid request' do
        before { post '/v1/signup', params: valid_attributes.to_json, headers: headers }

        it 'creates a new user' do
          expect(response).to have_http_status(201)
        end

        it 'returns success message' do
          expect(json['message']).to match(/Account created successfully/)
        end

        it 'returns an authentication token' do
          expect(json['auth_token']).not_to be_nil
        end
      end

      context 'when invalid request' do
        before { post '/v1/signup', params: {}, headers: headers }

        it 'does not create a new user' do
          expect(response).to have_http_status(422)
        end

        it 'returns failure message' do
          expect(json['message'])
            .to match(/Validation failed: First name can't be blank, Last name can't be blank, Email can't be blank, Password digest can't be blank, Password can't be blank/)
        end
      end
    end
end
