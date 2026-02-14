class Report < ApplicationRecord
  belongs_to :professor
  belongs_to :computer
  belongs_to :laboratory

  validates :description, :status, presence: true

  after_create_commit :trigger_webhook

  private

  def trigger_webhook
    WebhookJob.perform_later(self)
  end
end