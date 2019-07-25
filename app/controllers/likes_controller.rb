class LikesController < ApplicationController
  before_action :set_like, only: [:update, :destroy]

  def index
    object = params[:object_type]

    @likes = object.constantize.find(params[:object_id]).likes
  end

  def create
    like = current_user.likes.build(object_type: params[:object_type],
                                    object_id: params[:object_id],
                                    reaction_type: like_params[:reaction_type]
                                   )

    if like.save
      redirect_back fallback_location: root_path
    end
  end

  def update
    if @like.update(reaction_type: like_params[:reaction_type])
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:reaction_type)
  end

  def set_like
    @like = Like.find_by(object_type: params[:object_type], object_id: params[:object_id])
  end
end
