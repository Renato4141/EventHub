class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :events_attended, through: :registrations, source: :event

  enum :role, { regular: 0, admin: 2 }, default: :regular

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
end