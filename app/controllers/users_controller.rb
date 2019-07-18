class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    @friends = current_user.friends
    @posts = current_user.posts + current_user.friends.posts
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
