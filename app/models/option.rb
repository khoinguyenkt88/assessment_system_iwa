class Option < ApplicationRecord
  MINIMUM_CONTENT_LENGTH = 5.freeze

  belongs_to :question, inverse_of: :options

  validates :content, length: { minimum: MINIMUM_CONTENT_LENGTH }
end