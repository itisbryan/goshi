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
require 'rails_helper'

RSpec.describe PostVideo do
  pending "add some examples to (or delete) #{__FILE__}"
end
