class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :events_attended, through: :registrations, source: :event

  enum :role, { attendee: 0, organizer: 1, admin: 2 }, default: :attendee  # ← NUEVO

  validates :name, :email, presence: true
  validates :name, length: { minimum: 2, maximum: 50 }                      # ← NUEVO
  validates :email, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end