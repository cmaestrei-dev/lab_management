class Professor < ApplicationRecord
  has_many :reports, dependent: :destroy

  validates :name, :email, presence: true
end
