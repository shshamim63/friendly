module LikesHelper
  def liker(type, id, reaction )
    like = Like.find_by(object_type: type , object_id: id, user_id: current_user)
      if like.nil?
        create_likes_path(object_type: type, object_id: id, like: { reaction_type: reaction })
      elsif like.reaction_type == reaction
        destroy_likes_path(object_type: type, object_id: id, user_id: current_user, like: { reaction_type: reaction })
      else
        update_likes_path(object_type: type, object_id: id, like: { reaction_type: reaction })
      end
  end
end
