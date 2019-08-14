require 'rails_helper'

describe Comment, type: :model do
  describe "comment's associations" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
    it { should belong_to(:reply_from).class_name('Comment').optional.with_foreign_key(:reply_id) }
    it { should have_many(:replies).class_name('Comment').with_foreign_key(:reply_id) }
    it { should have_many(:likes) }
  end

  describe "comment's validity" do
    context 'when comment have all required fields' do
      let(:comment) { build(:comment) }

      it 'is a valid comment' do
        expect(comment).to be_valid
      end
    end

    context 'when comment does not contain a content' do
      let(:comment) { build(:comment, content: nil) }

      it 'is not a valid comment' do
        expect(comment).not_to be_valid
      end
    end
  end
end
