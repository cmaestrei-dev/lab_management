require "net/http"
require "uri"

class WebhookJob < ApplicationJob
  queue_as :default

  def perform(report)
    # IMPORTANTE: Reemplaza esta URL con la que copiaste en el Paso 1
    url = URI.parse("https://webhook.site/52c23d10-1294-4986-b82b-53ac01e4ccee") 

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true if url.scheme == "https"

    request = Net::HTTP::Post.new(url.path, { 'Content-Type' => 'application/json' })
    
    request.body = report.to_json(include: [:computer, :laboratory, :professor])

    response = http.request(request)
    
    Rails.logger.info "✅ Webhook enviado exitosamente. Respuesta: #{response.code}"
  rescue StandardError => e
    Rails.logger.error "❌ Error enviando webhook: #{e.message}"
  end
end
