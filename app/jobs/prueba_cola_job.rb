class PruebaColaJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Este mensaje se imprimirá en los logs de Render cuando el job se ejecute
    Rails.logger.info "======================================================="
    Rails.logger.info "🚀 ¡ÉXITO TOTAL! Solid Queue procesó este trabajo en segundo plano."
    Rails.logger.info "======================================================="
  end
end