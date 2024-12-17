class SecretTag < ApplicationRecord
  belongs_to :secret


  VALID_TAGS = ['Architecture', 'Street-art', 'Landscape', 'Not-tagged']

  validates :name, inclusion: { in: VALID_TAGS }
end
