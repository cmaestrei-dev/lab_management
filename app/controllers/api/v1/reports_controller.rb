module Api
  module V1
    class ReportsController < ApplicationController
      skip_before_action :verify_authenticity_token
      
      before_action :authenticate_api_key!

      def index
        @reports = Report.includes(:computer, :laboratory).all
        render json: @reports, include: [:computer, :laboratory]
      end

      private

      def authenticate_api_key!
        authenticate_or_request_with_http_token do |token, options|
          
          expected_api_key = ENV.fetch("BUK_API_KEY", "mi_clave_secreta_local_123")

          ActiveSupport::SecurityUtils.secure_compare(token, expected_api_key)
        end
      end
    end
  end
end
