json.array!(@api_v1_users) do |api_v1_user|
  json.extract! api_v1_user, :id
  json.url api_v1_user_url(api_v1_user, format: :json)
end
