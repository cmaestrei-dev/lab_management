json.extract! professor, :id, :professor_code, :name, :email, :program, :phone, :created_at, :updated_at
json.url professor_url(professor, format: :json)
