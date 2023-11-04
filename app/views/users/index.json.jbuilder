json.data do
  json.items do
    json.array!(@users) do |user|
      json.id user.id
      json.name user.name
      json.profile_image url_for(user.get_profile_image)
      json.address user.address
      json.latitude user.latitude
      json.longitude user.longitude
    end
  end
end