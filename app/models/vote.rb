class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :value, presence: true, inclusion: { in: [1, -1] }

  validates :user_id, uniqueness: { scope: :comment_id, message: "You have already voted on this comment" }
end
