class CommentsController < ApplicationController
  before_action :find_post

  def create
    @comment = @post.comments.build(post_params)

    if @comment.save
      redirect_back fallback_location: root_path
      flash.now[:success] = 'Comment was successfully created.'
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, :image)
  end
end
