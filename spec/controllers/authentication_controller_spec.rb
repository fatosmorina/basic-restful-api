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

end
