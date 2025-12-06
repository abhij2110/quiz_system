class Question < ApplicationRecord
  belongs_to :quiz

  QUESTION_TYPES = %w[mcq boolean text]

  validates :question_type, inclusion: { in: QUESTION_TYPES }
  validates :question_text, presence: true

  def parsed_options
    return [] if options.blank?

    options.is_a?(String) ? JSON.parse(options) : options
  end
  
end
