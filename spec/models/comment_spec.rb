require 'rails_helper'

describe Comment, type: :model do
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
