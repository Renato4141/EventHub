class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :rating, presence: true,
                     numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, length: { maximum: 500 }
  validates :user_id, uniqueness: { scope: :event_id }

  validate :event_must_be_finished, on: :create, unless: -> { event&.finished? }

  private

  def event_must_be_finished
    if event.present? && event.start_date > Date.today
      errors.add(:event, "must be finished to review")
    end
  end
end