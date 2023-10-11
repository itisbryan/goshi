# == Schema Information
#
# Table name: post_videos
#
#  id           :bigint           not null, primary key
#  description  :string           default(""), not null
#  title        :string           default(""), not null
#  video_source :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_post_videos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class PostVideo < ApplicationRecord
  belongs_to :user

  validates :video_source, presence: true
  validates :title, uniqueness: true

  scope :recent, -> { order(Arel.sql("date_trunc('second', created_at) DESC")) }

  after_create_commit { broadcast_message }

  private

  def broadcast_message
    ActionCable.server.broadcast('NotificationChannel', { message: "New video shared by #{user.login}" })
  end
end
