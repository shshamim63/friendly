require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:first_user) { create(:user) }
  let!(:first_post) { create(:post) }
  let!(:second_post) { create(:post) }

  before { sign_in first_user }


end
