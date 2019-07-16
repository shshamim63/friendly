require 'rails_helper'

describe User, type: :model do
  describe "user's validity" do
    context 'when user have all required fields' do
      let(:user) { build(:user) }

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
end
