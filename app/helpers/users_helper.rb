module UsersHelper
  include ActionView::RecordIdentifier

  # https://youtu.be/1cuEoc59cV8?si=HfwOAk7e9kIBx-BK&t=1188
  def following?(user)
    current_user&.followees&.include?(user)
  end

  def dom_id_for_follower(follower)
    dom_id(follower)
  end
end
