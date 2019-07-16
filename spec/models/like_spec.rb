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
end
