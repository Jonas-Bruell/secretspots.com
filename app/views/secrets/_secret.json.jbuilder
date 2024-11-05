json.extract! secret, :id, :naam, :beschrijving, :likes, :created_at, :updated_at
json.url secret_url(secret, format: :json)
