class CommentsController < ApplicationController
  before_action :find_post

  def create
    @comment = @post.comments.build(user_id: current_user.id, content: params[:comment][:content])

    if @comment.save
      redirect_to posts_path
      flash.now[:success] = 'Comment was successfully created.'
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
