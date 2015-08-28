json.array!(@shifts) do |shift|
  json.extract! shift, :id, :user_id, :date, :start_time
  json.url shift_url(shift, format: :json)
end
