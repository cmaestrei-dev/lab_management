json.extract! report, :id, :report_code, :description, :status, :report_date, :professor_id, :computer_id, :laboratory_id, :created_at, :updated_at
json.url report_url(report, format: :json)
