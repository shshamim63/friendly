class CommentsController < ApplicationController

  def create
    @comment = @post.comments.build(user_id: current_user.id, content: params[:content])

    if @comment.save
      redirect_to posts_path
      flash.now[:success] = 'Post was successfully created.'
    else
      render 'new'
    end
  end


  private

  def find_post
    @post = Post.find(params[:post_id])
  end

end
