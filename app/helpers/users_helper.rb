module UsersHelper
  include ActionView::RecordIdentifier

  # https://youtu.be/1cuEoc59cV8?si=HfwOAk7e9kIBx-BK&t=1188
  def following?(user)
    current_user&.followees&.include?(user)
  end

  def dom_id_for_follower(follower)
    dom_id(follower)
  end

  def update_following__count_and_button
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(dom_id_for_follower(@user),
            partial: 'users/follow_button',
            locals: { user: @user }),
          turbo_stream.update("#{@user.id}-follower-count",
            partial: 'users/follower_count',
            locals: { user: @user })
          ]
      end
    end
  end
end
