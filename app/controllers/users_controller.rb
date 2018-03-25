class UsersController < ApplicationController

  def my_portfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end

  def search
    if params[:search_param].blank?
      flash.now[:danger] = 'Enter a name or email'
    else
      @users = User.search(params[:search_param]).reject do |user|
        user.id == current_user.id
      end
      flash.now[:danger] = 'No user found' unless @users.present?
    end
    respond_to do |format|
      format.js { render partial: 'friends/result' }
      end
  end

  def friends
    @user_friends = current_user.friends
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      flash[:success] = "Friend added successfully"
    else
      flash[:danger] = "Something went wrong! Try again"
    end
    redirect_to friends_path
  end

  def show
    @user = User.find(params[:id])
    @user_stocks = @user.stocks
  end
end