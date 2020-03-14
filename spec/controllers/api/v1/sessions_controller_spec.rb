require 'spec_helper'

describe API::V1::SessionsController do
  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  describe '#create' do
    subject(:do_request) { post :create, params: { user: { email: user.email, password: '12345678' } }, format: :json }

    context 'when user is a teacher' do
      let(:user) { create :teacher }

      it 'returns unpermission error message' do
        do_request
        expect(json_response['success']).to be_falsey
        expect(json_response['message']).to eq 'You are not authorized to access this page.'
      end
    end

    context 'when user is a student' do
      context 'with invalid credentials' do
        let(:user) { create :student, password: 'fakepassword' }

        it 'returns authentication failed message' do
          do_request
          expect(json_response['success']).to be_falsey
          expect(json_response['message']).to eq('Authentication failed.')
        end
      end

      context 'with valid credentials' do
        let(:user) { create :student }

        it 'returns user with token' do
          do_request
          expect(json_response['user']['id']).to eq(user.id)
          expect(json_response['user']['auth_token']).to eq(user.user_sessions.last.token)
        end
      end
    end
  end

  describe '#destroy' do
    let(:user) { create :student }
    let(:user_session) { user.user_sessions.last }
    subject(:destroy_session) { delete :destroy, params: { auth_token: user_session.token }, format: :json }

    before { sign_in user }

    it 'deletes user session' do
      expect { destroy_session }.to change { UserSession.exists?(user_session.id) }.from(true).to(false)
    end
  end
end