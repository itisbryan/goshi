FactoryBot.define do
  factory :user do
    email { "test#{Time.current.to_f}@mail.com" }
    login { "user#{Time.current.to_f}" }
    password { "Password" }

    sequence :first_name do |n|
      "first_name_#{n}"
    end

    sequence :last_name do |n|
      "last_name_#{n}"
    end
  end
end
