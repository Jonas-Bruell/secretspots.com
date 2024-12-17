# users_controller.rb
class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user

  def show
  end

  def followers; end

  def following; end

  def follow
    Relationship.create_or_find_by(follower_id: current_user.id, followee_id: @user.id)
    update_following_count_and_button
  end

  def unfollow
    current_user.followed_users.where(follower_id: current_user.id, followee_id: @user.id).destroy_all
    update_following_count_and_button
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
