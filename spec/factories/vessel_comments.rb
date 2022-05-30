FactoryBot.define do
  factory :vessel_comment do
    user
    vessel
    assigned_date { Date.today }
    message { "MyString" }
  end
end
