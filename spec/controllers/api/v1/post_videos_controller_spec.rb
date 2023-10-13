require 'rails_helper'

RSpec.describe Api::V1::PostVideosController do
  describe 'GET #index' do
    it 'returns a list of post videos' do
      create_list(:post_video, 2)

      get :index
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)['details']['videos'].count).to eq(2)
    end
  end

  describe 'POST #create' do
    let(:current_user) { create(:user) }
    let(:token) { JwtWrapper.encode({ user_id: current_user.id }) }
    let(:headers) do
      { 'Authorization' => token }
    end
    let(:post_video) do
      {
        title: 'test video',
        description: 'lorem ipsum',
        video_source: "https://www.youtube.com/watch?v=#{Random.rand(100)}"
      }
    end
    let(:post_params) do
      {
        post_video:
      }
    end

    it 'requires authentication' do
      post :create, params: post_params

      expect(response).to have_http_status :unauthorized
      expect(JSON.parse(response.body)['details']).to eq 'invalid_token'
    end

    it 'creates post video successfully' do
      login do
        post :create, params: post_params

        expect(response).to have_http_status :created
        expect(JSON.parse(response.body)['message']).to eq 'Created'
      end
    end

    context 'when params is invalid' do
      it 'does not create new post video since params is empty' do
        login do
          post :create, params: {}

          expect(response).to have_http_status :unprocessable_entity
          expect(JSON.parse(response.body)['message']).to eq 'Post_video is missing'
        end
      end

      it 'does not create new post video since it is missing title' do
        login do
          post_video.except!(:title)
          post :create, params: post_params

          expect(response).to have_http_status :unprocessable_entity
          expect(JSON.parse(response.body)['message']).to eq 'Title is missing'
        end
      end

      it 'does not create new post video since it is missing title' do
        login do
          post_video.except!(:description)
          post :create, params: post_params

          expect(response).to have_http_status :unprocessable_entity
          expect(JSON.parse(response.body)['message']).to eq 'Description is missing'
        end
      end

      it 'does not create new post video since it is missing video_source' do
        login do
          post_video.except!(:video_source)
          post :create, params: post_params

          expect(response).to have_http_status :unprocessable_entity
          expect(JSON.parse(response.body)['message']).to eq 'Video_source is missing'
        end
      end
    end
  end

  private

  def login(&)
    request.headers.merge!(headers)
    yield if block_given?
  end
end
