class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def add
    record1 = Friendship.current_status?(current_user, @user)
    record2 = Friendship.current_status?(@user, current_user)
    if record1.id > record2.id
      record = record1
    else
      record = record2
    end
    if record.present?
      friendship = Friendship.new(user_id: record.user_id, friend_id: record.friend_id, status: 'pending')

      if friendship.save
        redirect_to users_path
      end
    end
    redirect_to users_path
  end

  def unfriend
    if Friendship.still_friends?( current_user, @user)
      friendship = current_user.friendships.build(friend: @user, status: 'unfriended')
    else
      friendship = @user.friendships.build(friend: current_user, status: 'unfriended')
    end
    if friendship.save
      redirect_to users_path
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:user_id])
  end
end
