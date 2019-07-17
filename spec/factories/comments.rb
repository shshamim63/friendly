FactoryBot.define do
  factory :comment do
    content { 'party is going on' }
    user { create(:user) }
    post { create(:post) }
  end
end
