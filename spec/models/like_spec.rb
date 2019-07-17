require 'rails_helper'

describe Like, type: :model do
  describe "likes's validation" do
    context 'when user likes on a post' do
      let(:like) { create(:like) }

      it 'contains users like on a post' do
        expect(like.object_type).to eq('Post')
      end
    end
  end

  describe "likes's associations" do
    it { should define_enum_for(:reaction_type).with_values([ :like, :dislike, :laugh ]) }
    it { should belong_to(:object) }
    it { should belong_to(:user) }
  end
end
