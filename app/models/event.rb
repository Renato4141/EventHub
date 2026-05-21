class Event < ApplicationRecord
  belongs_to :user
  belongs_to :venue, optional: true
  has_rich_text :description
  has_many :registrations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :event_categories, dependent: :destroy
  has_many :categories, through: :event_categories

  validates :name, :date, :capacity, presence: true
  validates :name, length: { minimum: 3, maximum: 100 }
  validates :capacity, numericality: { greater_than: 0, only_integer: true }

  enum :status, { draft: 0, published: 1, finished: 2 }

  validate :date_cannot_be_in_the_past, on: :create, unless: :finished?

  private

  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "cannot be in the past")
    end
  end
end