class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum :status, { confirmed: 0, cancelled: 1, waitlisted: 2}

  validates :user_id, uniqueness: { scope: :event_id }

  validate :event_capacity_not_exceeded
  validate :event_must_be_published, on: :create
  
  # CAMBIO 1: Cambiamos before_create por before_validation
  before_validation :assign_initial_status, on: :create

  after_update :handle_cancellation, if: -> { saved_change_to_status? && cancelled? }

  private

  def event_capacity_not_exceeded
    return unless event.present?
    
    # Excluimos los cancelados y en lista de espera del conteo activo
    active_count = event.registrations.where(status: %i[pending confirmed]).count
    
    if active_count >= event.capacity && !waitlisted? && !cancelled?
      errors.add(:event, "is full")
    end
  end

  def event_must_be_published
    unless event&.published?
      errors.add(:base, "You can only register for published events.")
    end
  end

  def assign_initial_status
    return if status == 'cancelled'

    self.status = event.full? ? :waitlisted : :confirmed
  end

  def handle_cancellation
    if status_before_last_save == 'confirmed'
      event.promote_next_waitlisted!
    end
  end
end