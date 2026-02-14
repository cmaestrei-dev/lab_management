module Api
  module V1
    class ReportsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        @reports = Report.includes(:computer, :laboratory).all
        render json: @reports, include: [:computer, :laboratory]
      end
    end
  end
end
