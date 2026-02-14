class Report < ApplicationRecord
  belongs_to :professor
  belongs_to :computer
  belongs_to :laboratory
end
