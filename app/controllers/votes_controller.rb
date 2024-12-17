class VotesController < ApplicationController
  before_action :set_comment, only: [:create, :destroy]

  def create
    @vote = @comment.votes.find_or_initialize_by(user: current_user)

    if @vote.new_record?
      @vote.value = params[:value]
    else
      @vote.update(value: params[:value])
    end

    if @vote.save
      redirect_to secret_path(@comment.secret), notice: 'Vote was successfully recorded.'
    else
      redirect_to secret_path(@comment.secret), alert: 'Failed to vote.'
    end
  end

  def delete
    @vote = current_user.votes.find_by(comment: @comment)

    if @vote
      @vote.destroy
      redirect_to secret_path(@comment.secret), notice: 'Vote removed.'
    else
      redirect_to secret_path(@comment.secret), alert: 'Vote not found.'
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
end
