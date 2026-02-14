class Component < ApplicationRecord
  belongs_to :computer

  validates :name, :serial_num, presence: true
end