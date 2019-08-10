class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!

  def index
    if user_signed_in?
      @post = Post.new
      @comment = Comment.new
      user_with_posts_to_show = current_user.friends
      user_with_posts_to_show << current_user
      @posts = Post.timeline(user_with_posts_to_show)
    else
      redirect_to new_user_registration_path
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.images.attach(params[:post][:images]) if params[:post][:images] != nil

    if @post.save
      flash.now[:success] = 'Post was successfully created.'
      redirect_to posts_path
    else
      flash.now[:danger] = 'unable to create post'
      redirect_back fallback_location: root_path
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
    session[:return_to] ||= request.referer
  end

  def update
    if @post.update(post_params)
      flash.now[:success] = 'Post was successfully updated.'
      redirect_to session.delete(:return_to)
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash.now[:danger] = 'Post was successfully destroyed.'
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
