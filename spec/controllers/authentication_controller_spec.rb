require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do

  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let!(:headers) { valid_headers.except('Authorization') }

    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
  end

  context 'when request is valid' do
    before { post '/auth/login', params: valid_credentials, headers: headers}

    it 'should return an authentication token' do
      expect(json['auth_token']).not_to be_nil
    end
  end

  context 'when request is invalid' do
    before { post '/auth/login', params: invalid_credentials, headers: headers }

    it 'should return a failure message' do
      expect(json['message']).to match(/Invalid credentials/)
    end
  end

end
