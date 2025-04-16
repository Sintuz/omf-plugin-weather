function weather.location -d "Get the current geographic location"
  # Attempt to get our external IP address.
  if not set ip (__weather_get_ip)
    echo "No Internet connection or IP service unavailable."
    return 1
  end

  # Fetch location data based on our IP
  if not set geoip_data (weather.fetch "http://ip-api.com/json/$ip")
    echo "Unable to query GeoIP data; please try again later."
    return 1
  end

  # Echo coordiantes.
  echo $geoip_data | jq '.lat'
  echo $geoip_data | jq '.lon'
  echo $geoip_data | jq -r '.city?'
  echo $geoip_data | jq -r '.country'
end

function __weather_get_ip -d "Get the current device's public IP address"
  # Attempt to get our external IP using a web service.
  if set ip (weather.fetch "https://ipecho.net/plain")
    echo $ip
  end

end
