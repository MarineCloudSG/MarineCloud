FactoryBot.define do
  factory :vessel_comment do
    user
    vessel
    message { "MyString" }
  end
end
