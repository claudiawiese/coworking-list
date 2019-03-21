class Request < ApplicationRecord
  validates :client_first_name, presence: true
  validates :client_last_name, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :phone, presence: true
  validates :bio, presence: true
end
