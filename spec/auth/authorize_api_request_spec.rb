require 'rails_helper'

RSpec.describe AuthorizeApiRequest do

  let(:user) { create(:user) }
  let(:header) {{'Authorization' => token_generator(user.id) }}
  subject(:invalid_request_obj) {described_class.new({})}

  describe '#call' do
    context 'when valid request' do
      it 'should return user object' do
        result = request_obj.call
        expect(result[:user]).to eq(user)
      end
    end
  end

end