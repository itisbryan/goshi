require 'rails_helper'

RSpec.describe PostVideo, type: :video do
  describe '#save' do
    it 'is valid with valid attributes' do
      post_video = build(:post_video)
      expect(post_video.valid?).to be(true)
    end

    it 'is not valid without title' do
      post_video = described_class.new(title: '')
      expect(post_video.valid?).to be(false)
    end

    it 'is not valid without description' do
      post_video = described_class.new(description: '')
      expect(post_video.valid?).to be(false)
    end

    it 'is not valid without video source' do
      post_video = described_class.new(video_source: '')
      expect(post_video.valid?).to be(false)
    end
  end

  describe '#scope' do
    it 'returns the correct order for recent scope' do
      post_video_first = create(:post_video, created_at: 3.days.ago)
      post_video_second = create(:post_video)
      expect(described_class.recent).to eq([post_video_second, post_video_first])
    end
  end
end
