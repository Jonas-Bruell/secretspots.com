# users_controller.rb
class UsersController < ApplicationController
  before_action :set_user

  def show; end

  def follow
    Friend.create_or_find_by(follower_id: current_user.id, followee_id: @user.id)
  end

  def unfollow
    current_user.followed_users.where(follower_id: current_user.id, followee_id: @user.id).destroy_all
  end

  private

  def set_user
    @user = User.find(params[:id])
    @secrets = Secret.where(user_id: @user.id)
    @comments = Comment.where(user_id: @user.id).includes(:secret)
  end
end
