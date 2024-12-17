class SecretTag < ApplicationRecord
  belongs_to :secret

  belongs_to :secret

  VALID_TAGS = ['architecture', 'street-art', 'landscape', 'not-tagged']

  validates :name, inclusion: { in: VALID_TAGS }
end
