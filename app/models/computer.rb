class Computer < ApplicationRecord
  belongs_to :laboratory
  has_many :components, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :serial_num, presence: true, uniqueness: true
end
