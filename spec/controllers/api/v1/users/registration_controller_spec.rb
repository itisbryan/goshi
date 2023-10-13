require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationController do
  describe 'POST #join' do
    let(:user) do
      {
        email: "test#{Random.rand(10)}@mail.test",
        password: 'test-password',
        login: 'user',
        first_name: 'user',
        last_name: 'user'
      }
    end
    let(:user_params) do
      {
        user:
      }
    end

    it 'creates post video successfully' do
      post :join, params: user_params

      expect(response).to have_http_status :created
      expect(JSON.parse(response.body)['message']).to eq 'Create account successfully'
    end

    context 'when params is not valid' do
      it 'does not create new post video since params is empty' do
        post :join, params: {}

        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)['message']).to eq 'User is missing'
      end

      it 'does not create new post video since email is empty' do
        user.except!(:email)
        post :join, params: user_params

        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)['message']).to eq 'Email is missing'
      end

      it 'does not create new post video since email is in invalid format' do
        user[:email] = 'test.com'
        post :join, params: user_params

        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)['message']).to eq 'Email is invalid'
      end

      it 'does not create new post video since password is less than 6 characters' do
        user[:password] = '12345'
        post :join, params: user_params

        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)['message']).to eq 'Password is invalid'
      end

      it 'does not create new post video since password is more than 128 characters' do
        user[:password] = '1' * 129
        post :join, params: user_params

        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)['message']).to eq 'Password is invalid'
      end

      it 'does not create new post video since login is empty' do
        user.except!(:login)
        post :join, params: user_params

        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)['message']).to eq 'Login is missing'
      end

      it 'does not create new post video since first_name is empty' do
        user.except!(:first_name)
        post :join, params: user_params

        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)['message']).to eq 'First_name is missing'
      end

      it 'does not create new post video since last_name is empty' do
        user.except!(:last_name)
        post :join, params: user_params

        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)['message']).to eq 'Last_name is missing'
      end
    end
  end
end
