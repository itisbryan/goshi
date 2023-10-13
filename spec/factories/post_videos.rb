FactoryBot.define do
  factory :post_video do
    user

    sequence :title do |n|
      "video_#{n}"
    end
    sequence :description do |n|
      "description_#{n}"
    end

    sequence :video_source do |n|
      "https://www.youtube.com/embed/#{n}"
    end
  end
end
