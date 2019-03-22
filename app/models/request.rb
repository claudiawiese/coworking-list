class Request < ApplicationRecord
  validates :client_first_name, presence: true
  validates :client_last_name, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :phone, presence: true
  validates :bio, presence: true

  scope :unconfirmed, -> { where(status: 'unconfirmed') }
  scope :confirmed, -> { where(status: 'confirmed') }
  scope :accepted, -> { where(status: 'accepted') }
  scope :expired, -> { where(status: 'expired') }
  scope :accept!, -> { where(status: 'confirmed').update(status: 'accepted') }

  def accept!
    self.update(status: "accepted")
  end
end
