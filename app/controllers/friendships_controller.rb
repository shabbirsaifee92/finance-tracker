class FriendshipsController < ApplicationController

  def destroy
    @frienship = current_user.friendships.find_by(friend_id: params[:id])
    @frienship.destroy
    flash[:notice] = "Friend was successfullt removed"
    redirect_to friends_path
  end
end