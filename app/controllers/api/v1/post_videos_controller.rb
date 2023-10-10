# frozen_string_literal: true

module Api
  module V1
    class PostVideosController < ApplicationController
      before_action :authenticate_request!

      def index
        post_videos = @current_user.post_videos.recent
        serialized_videos =
          ActiveModel::Serializer::CollectionSerializer.new(post_videos, serializer: PostVideoSerializer)

        success_response({ videos: serialized_videos }, 200, 'OK')
      end

      def create
        post_video = Api::V1::PostVideos::CreateVideo.call(@current_user, params)
        success_response(PostVideoSerializer.new(post_video), 201, 'Created')
      end
    end
  end
end
