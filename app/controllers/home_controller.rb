class HomeController < ApplicationController
  def index
    @total_reports_count = Report.count
    @failing_computers_count = Computer.where(status: 'En Mantenimiento').count
    @saturated_labs_count = Laboratory.where('capacity < ?', 30).count

    @recent_reports = Report.includes(:professor, :computer)
                            .order(created_at: :desc)
                            .limit(10)
  end
end
