require 'rails_helper'

describe Post, type: :model do
  describe "post's validation" do
    context 'when post have all required fields' do
      let(:post) { build(:post) }

      it 'is a valid post' do
        expect(post).to be_valid
      end
    end

    context 'when post does not contain a content' do
      let(:post) { build(:post, content: nil) }

      it 'is not a valid post' do
        expect(post).not_to be_valid
      end
    end
  end

  describe "post's associations" do
    it { belong_to(:user) }
    it { have_many(:likes) }
    it { have_many(:comments) }
  end
end
