class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :secret

  validates :content, presence: true
end
