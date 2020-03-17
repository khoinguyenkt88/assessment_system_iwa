class Test < ApplicationRecord
  MINIMUM_LENGTH = 5.freeze
  MAXIMUM_LENGTH = 255.freeze
  QUESTIONS_COUNT_MIN = 1.freeze

  has_many :questions, dependent: :destroy, inverse_of: :test

  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank

  validates :name, length: { minimum: 5, maximum: MAXIMUM_LENGTH }, uniqueness: true
  validate :check_questions_number, on: %i[create update]

  private

  def questions_count_valid?
    questions.reject(&:marked_for_destruction?).count >= QUESTIONS_COUNT_MIN
  end

  def check_questions_number
    return true if questions_count_valid?

    errors.add(:test, I18n.t('errors.has_at_least_correct', min_count: QUESTIONS_COUNT_MIN, model: 'question'))
  end
end