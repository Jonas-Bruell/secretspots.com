json.extract! secret, :id, :user_id, :name, :body, :created_at, :updated_at
json.url secret_url(secret, format: :json)
