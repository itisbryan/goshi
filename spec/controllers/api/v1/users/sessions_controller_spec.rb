require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController do
  describe 'POST #join' do
    let(:user) { create(:user) }
    let(:user_payload) do
      {
        email: user.email,
        password: user.password,
      }
    end
    let(:login_params) do
      {
        user: user_payload
      }
    end

    it 'sign in successfully' do
      post :login, params: login_params

      expect(response).to have_http_status :created
      expect(JSON.parse(response.body)['message']).to eq 'Authenticated'
    end
  end
end
