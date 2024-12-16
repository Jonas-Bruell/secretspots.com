class Secret < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

# https://www.youtube.com/watch?v=nqAnftA8LbA
# https://www.youtube.com/watch?v=1cw6qO1EYGw

#  def image_as_thumbnail
#    image.variant(resize_to_limit: [200, 200]).processed
#  end

def image_as_thumbnail
  image
end


  validates :description, presence: true, length: { minimum: 1 }
  validates :name, presence: true
  validates :image, presence: true
  validates :body, length: { minimum: 1 }, allow_blank: true
end
