class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    @friends = User.all
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
