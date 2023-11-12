json.extract! request, :id, :status, :availability_id, :sender_id, :created_at, :updated_at
json.url request_url(request, format: :json)
