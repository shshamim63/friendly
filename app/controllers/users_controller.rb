class UsersController < ApplicationController
  before_action :find_user
  before_action :authenticate_user!

  def index
    @user = User.all_except(current_user)
  end

  def new
  end

  def create
  end

  def show
    @post = Post.new
    @comment = Comment.new
    @posts = @user.posts
    
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
