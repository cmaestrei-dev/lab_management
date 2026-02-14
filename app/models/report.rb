class Report < ApplicationRecord
  belongs_to :professor
  belongs_to :computer
  belongs_to :laboratory

  validates :description, :status, presence: true

  after_commit :trigger_webhook, on: [:create, :update]

  private

  def trigger_webhook
    WebhookJob.perform_later(self)
  end
end