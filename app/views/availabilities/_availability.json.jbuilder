json.extract! availability, :id, :user_id, :start_time, :end_time, :location, :description, :is_open, :created_at, :updated_at
json.url availability_url(availability, format: :json)
