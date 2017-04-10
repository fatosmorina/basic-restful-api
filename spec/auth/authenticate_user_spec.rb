require 'rails_helper'

RSpec.describe AuthenticateUser do

  let(:user) { create(:user) }

  subject(:valid_auth_object) { described_class.new(user.email, user.password) }

  subject(:invalid_auth_object) { described_class.new('user','user')}

  describe '#call' do

    context 'when valid credentials' do
      it 'should return an auth token' do
        token = valid_auth_object.call
        expect(token).not_to be_nil
      end
    end

    context 'when invalid credentials' do
      it 'should raise an authentication error' do
        expect { invalid_auth_object.call }.to
        raise_error(ExceptionHandler::AuthenticationError,
        /Invalid credentials/
        )
      end
    end

  end
end