class PostVideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :url, :shared_by, :created_at

  def created_at
    object&.created_at&.iso8601
  end

  def shared_by
    object&.user&.login
  end

  def url
    object&.video_source
  end
end
