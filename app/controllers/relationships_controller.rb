class RelationshipsController < ApplicationController
  before_action :set_relationship, only: %i[ show ]

  def index
    @relationships = User.all
  end

  private

  def set_relationship
    @relationships = User.find(params[:user_id])
  end
end
