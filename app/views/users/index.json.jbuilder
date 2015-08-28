json.array!(@users) do |user|
  json.extract! user, :id, :family_name, :first_name, :age
  json.url user_url(user, format: :json)
end
