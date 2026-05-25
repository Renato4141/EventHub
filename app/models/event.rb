class Event < ApplicationRecord
  belongs_to :user
  belongs_to :venue, optional: true
  has_rich_text :description
  has_many :registrations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :event_categories, dependent: :destroy
  has_many :categories, through: :event_categories

  validates :name, :start_date, :end_date, :capacity, presence: true
  validates :name, length: { minimum: 3, maximum: 100 }
  validates :capacity, numericality: { greater_than: 0, only_integer: true }

  enum :status, { draft: 0, published: 1, finished: 2, cancelled: 3, ongoing: 4 }

  after_update :destroy_registrations_if_cancelled, if: -> { saved_change_to_status? && cancelled? }

  validate :date_cannot_be_in_the_past, on: :create, unless: :finished?

  validate :end_date_after_start_date

  validate :capacity_must_be_within_venue_limit

  def available_spots
    capacity - registrations.confirmed.count
  end

  def full?
    available_spots <= 0
  end

  def promote_next_waitlisted!
    next_in_line = registrations.waitlisted.order(:created_at).first
    
    if next_in_line
      next_in_line.update!(status: :confirmed)
    end
  end

  private

  def date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "cannot be in the past")
    end
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def destroy_registrations_if_cancelled
    registrations.destroy_all
  end

  def capacity_must_be_within_venue_limit
    if venue.present? && venue.capacity.present? && capacity.present?
      if capacity > venue.capacity
        errors.add(:capacity, "cannot exceed the maximum capacity of the venue (max: #{venue.capacity})")
      end
    end
  end

end