require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:first_user) { create(:user) }
  let!(:second_user) { create(:user) }
  let!(:third_user) { create(:user) }

  before { sign_in first_user }

  describe '#index' do
    it 'return all user expect current_user' do
      get :index

      expect(response).to render_template :index
      expect(assigns(:user).count).to eq 2
      expect(assigns(:user).first.id).to eq second_user.id
      expect(assigns(:user).last.id).to eq third_user.id
    end
  end

  describe '#show' do
    let!(:first_post) { create(:post, user: second_user) }
    let!(:second_post) { create(:post, user: second_user) }
    let!(:third_post) { create(:post, user: first_user) }

    it 'returns current_user data' do
      get :show, params: { id: second_user }

      expect(response).to render_template :show
      expect(assigns(:post).class.name).to eq 'Post'
      expect(assigns(:comment).class.name).to eq 'Comment'
      expect(assigns(:posts).count).to eq 2
      expect(assigns(:posts).first.id).to eq first_post.id
      expect(assigns(:posts).last.id).to eq second_post.id
    end
  end
end
