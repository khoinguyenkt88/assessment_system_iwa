class Test < ApplicationRecord
  has_many :questions, dependent: :destroy, inverse_of: :test
end