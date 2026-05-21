class Venue < ApplicationRecord
  has_many :events, dependent: :nullify

  validates :name, :address, presence: true
  validates :capacity, numericality: { greater_than: 0 }, allow_nil: true
end