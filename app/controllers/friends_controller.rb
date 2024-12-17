class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show ]

  def index
    @friends = User.all
  end

  private

  def set_friend
    @friend = User.find(params[:user_id])
  end
end
