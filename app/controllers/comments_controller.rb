class CommentsController < ApplicationController
  before_action :set_secret

  def create
    @comment = @secret.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @secret, notice: 'Comment was successfully created.'
    else
      redirect_to @secret, alert: 'Error creating comment.'
    end
  end

  def destroy
    @comment = @secret.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to @secret, notice: 'Comment was successfully deleted.'
    else
      redirect_to @secret, alert: 'You can only delete your own comments.'
    end
  end

  def edit
    @comment = @secret.comments.find(params[:id])
    redirect_to @secret, alert: 'You can only edit your own comments.' unless @comment.user == current_user
  end

  def update
    @comment = @secret.comments.find(params[:id])
    if @comment.user == current_user && @comment.update(comment_params)
      @comment.update(edited: true)
      redirect_to @secret, notice: 'Comment was successfully updated.'
    else
      redirect_to @secret, alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

  def set_secret
    @secret = Secret.find(params[:secret_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
