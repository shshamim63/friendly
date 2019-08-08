class CommentsController < ApplicationController
  before_action :find_post

  def create
    @comment = @post.comments.build(user_id: current_user.id, content: params[:comment][:content])
    @comment.image.attach(params[:comment][:image]) if params[:comment][:images] != nil

    if @comment.save
      flash.now[:success] = 'Comment was successfully created.'
      redirect_back fallback_location: root_path
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
