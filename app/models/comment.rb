class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :secret
  has_many :votes, dependent: :destroy

  validates :content, presence: true
end
