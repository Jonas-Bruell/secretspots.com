class Secret < ApplicationRecord
  belongs_to :user
  has_one_attached :Pictures
end
