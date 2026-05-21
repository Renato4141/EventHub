class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :status, { pending: 0, confirmed: 1, cancelled: 2, waitlisted: 3 }

  validates :user_id, uniqueness: { scope: :event_id }

  validate :event_capacity_not_exceeded

  private

  def event_capacity_not_exceeded
    return unless event.present?
    active_count = event.registrations.where(status: %i[pending confirmed]).count
    if active_count >= event.capacity && !waitlisted?
      errors.add(:event, "is full")
    end
  end
end