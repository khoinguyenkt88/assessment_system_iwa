class Question < ApplicationRecord
  has_many :options, dependent: :destroy, inverse_of: :question
  belongs_to :test, inverse_of: :questions
end