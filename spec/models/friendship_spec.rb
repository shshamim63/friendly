require 'rails_helper'

describe Friendship, type: :model do
  describe 'Friendship associations' do
    it { should define_enum_for(:status).with_values([ :accepted, :rejected, :unfriended ]) }
    it { should belong_to(:friend).class_name('User').with_foreign_key(:friend_id) }
    it { should belong_to(:user) }
  end

  describe 'still_friends?' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }

    context 'when users are still friends' do
      let!(:friendship_rejected) { create(:friendship, user: user, friend: friend, status: 'rejected') }
      let!(:friendship_accepted) { create(:friendship, user: user, friend: friend, status: 'accepted') }

      it 'is still a friendship' do
        expect(described_class.still_friends?(user, friend)).to be true
      end
    end

    context 'when users are  not friends anymore' do
      let!(:friendship_accepted) { create(:friendship, user: user, friend: friend, status: 'accepted') }
      let!(:friendship_unfriended) { create(:friendship, user: user, friend: friend, status: 'unfriended') }

      it 'is not a friendship anymore' do
        expect(described_class.still_friends?(user, friend)).to be false
      end
    end
  end
end
