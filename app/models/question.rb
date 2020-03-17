class Question < ApplicationRecord
  OPTIONS_COUNT_MIN = 1.freeze
  OPTIONS_CORRECT_MIN = 1.freeze
  MINIMUM_LABEL_LENGTH = 5.freeze

  has_many :options, dependent: :destroy, inverse_of: :question
  belongs_to :test, inverse_of: :questions

  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: :all_blank

  before_validation :parameterize_label, on: %i[create update], if: -> { label_changed? }

  validates :label, length: { minimum: MINIMUM_LABEL_LENGTH }

  validate :check_options_number, on: %i[create update]
  validate :has_at_least_one_correct_option, on: %i[create update]

  private

  def options_count_valid?
    options.reject(&:marked_for_destruction?).count >= OPTIONS_COUNT_MIN
  end

  def check_options_number
    return true if options_count_valid?

    test.errors.add(:questions, I18n.t('errors.has_at_least_defined', min_count: OPTIONS_COUNT_MIN, model: 'option'))
  end

  def has_at_least_one_correct_option
    return true if options.select { |e| e.correct }.any?

    test.errors.add(:questions, I18n.t('errors.has_at_least_correct', min_count: OPTIONS_CORRECT_MIN, model: 'option'))
  end

  def parameterize_label
    self.label = label.squish.parameterize(separator: '_')
  end
end