FactoryBot.define do
  factory :post do
    content { 'party is going on' }
    user { create(:user) }
  end
end
