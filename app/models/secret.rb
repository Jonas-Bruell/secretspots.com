class Secret < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  def image_as_thumbnail
    image.variant(resize_to_limit: [200, 200]).processed
  end
end
