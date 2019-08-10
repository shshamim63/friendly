require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:first_user) { create(:user) }
  let(:post) { build(:post) }
  before { sign_in first_user }
end
