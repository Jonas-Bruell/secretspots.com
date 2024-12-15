# users_controller.rb
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @secrets = Secret.where(user_id: @user.id)
    @comments = Comment.where(user_id: @user.id).includes(:secret)
  end
end
