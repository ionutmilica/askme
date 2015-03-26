json.array!(@cars) do |car|
  json.extract! car, :id, :color, :hp, :model
  json.url car_url(car, format: :json)
end
