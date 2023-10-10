module Api
  module V1
    module PostVideos
      class CreateVideo
        include BaseService
        attr_reader :current_user, :params

        def initialize(current_user, params)
          @current_user = current_user
          @params = params
        end

        def call
          post_video = current_user.post_videos.build(validated_params[:post_video])
          raise Errors::Exceptions::InvalidResource, post_video.errors.full_messages.first unless post_video.valid?

          post_video.save!

          post_video
        end

        private

        def validated_params
          @validated_params ||= ParamsValidator.new do
            mandatory :post_video do
              mandatory :title, type: String
              mandatory :video_source, type: String, transform: ->(val) { val.gsub!("watch?v=", "embed/").split("&").first }
              mandatory :description, type: String
            end
          end.build(params)
        end
      end
    end
  end
end
