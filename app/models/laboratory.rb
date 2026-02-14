class Laboratory < ApplicationRecord
  has_many :computers, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :name, :location, presence: true
end