require 'rails_helper'

describe User, type: :model do
  describe "user's validity" do
    context 'when user have all required fields' do
      let!(:user) { build(:user) }

      it 'is a valid user' do
        expect(user).to be_valid
      end
    end

    context 'when user does not have first name' do
      let(:user) { build(:user, first_name: nil) }

      it 'is not valid user' do
        expect(user).not_to be_valid
      end
    end

    context 'when user does not have email' do
      let(:user) { build(:user, email: nil) }

      it 'not valid user' do
        expect(user).not_to be_valid
      end
    end

    context 'when user does not have password' do
      let(:user) { build(:user, password: nil) }

      it "not a valid user" do
        expect(user).not_to be_valid
      end
    end
  end

  describe "friends" do
    context 'when user is friend and inverse friend' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:user3) { create(:user) }
      let!(:friendships1) { create(:friendship, user: user1, friend: user2, status: 'accepted') }
      let!(:friendships2) { create(:friendship, user: user3, friend: user1, status: 'accepted') }

      it 'returns all friends' do
        expect(user1.friends.count).to eq(2)
      end
    end
  end
end
