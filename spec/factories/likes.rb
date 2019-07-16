FactoryBot.define do
  factory :like do
    user { create(:user) }
    object { create(:post) }
    reaction_type { 0 }
  end
end
