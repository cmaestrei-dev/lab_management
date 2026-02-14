module Api
  module V1
    class ReportsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_api_key!

      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
      rescue_from StandardError, with: :handle_internal_error

      def index
        page = (params[:page] || 1).to_i
        per_page = (params[:per_page] || 20).to_i
        
        per_page = 100 if per_page > 100 
        
        offset = (page - 1) * per_page

        @reports = Report.includes(:computer, :laboratory)
                         .limit(per_page)
                         .offset(offset)

        total_count = Report.count
        total_pages = (total_count.to_f / per_page).ceil

        next_link = if page < total_pages
                      api_v1_reports_url(page: page + 1, per_page: per_page)
                    else
                      nil
                    end

        render json: {
          "@count": total_count,
          "@nextLink": next_link,
          "value": @reports.as_json(include: [:computer, :laboratory])
        }
      end

      private

      def authenticate_api_key!
        token_valid = authenticate_with_http_token do |token, options|
          expected_api_key = ENV.fetch("BUK_API_KEY", "mi_clave_secreta_local_123")
          ActiveSupport::SecurityUtils.secure_compare(token, expected_api_key)
        end

        unless token_valid
          render json: {
            error: {
              code: "unauthorized",
              message: "Acceso denegado. Token inválido o no proporcionado."
            }
          }, status: :unauthorized # Código HTTP 401
        end
      end


      def handle_not_found(exception)
        render json: {
          error: {
            code: "not_found",
            message: "El recurso solicitado no fue encontrado.",
            details: exception.message
          }
        }, status: :not_found # Código HTTP 404
      end

      def handle_internal_error(exception)
        Rails.logger.error("API Error: #{exception.message}") 
        
        render json: {
          error: {
            code: "internal_server_error",
            message: "Ocurrió un error inesperado en el servidor al procesar la solicitud."
          }
        }, status: :internal_server_error # Código HTTP 500
      end
    end
  end
end