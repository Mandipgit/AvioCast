import requests
from config.settings import settings


def get_forecast_weather(latitude: float, longitude: float) -> dict:
   
    params = {
        "latitude": latitude,
        "longitude": longitude,
        "current_weather": True
    }

    response = requests.get(
        settings.WEATHER_API_BASE_URL,
        params=params,
        timeout=settings.HTTP_TIMEOUT
    )

    response.raise_for_status()

    data = response.json()
    current = data.get("current_weather", {})

    return {
        "latitude": latitude,
        "longitude": longitude,
        "temperature_c": current.get("temperature"),
        "wind_speed_kt": current.get("windspeed"),
        "wind_direction_deg": current.get("winddirection"),
        "weather_code": current.get("weathercode"),
        "source": "open-meteo"
    }
