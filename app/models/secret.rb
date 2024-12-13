class Secret < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  def image_as_thumbnail
    image.variant(resize_to_limit: [200, 200]).processed
  end
end
