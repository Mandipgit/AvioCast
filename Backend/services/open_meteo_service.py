import requests
from config.settings import settings


def get_forecast_weather(latitude: float, longitude: float) -> dict:
   
    params = {
        "latitude": latitude,
    "longitude": longitude,
    "current": [
        "temperature_2m",
        "windspeed_10m",
        "winddirection_10m",
        "visibility"
    ]
    }

    response = requests.get(
        settings.WEATHER_API_BASE_URL,
        params=params,
        timeout=settings.HTTP_TIMEOUT
    )

    response.raise_for_status()

    data = response.json()
    current = data.get("current", {})


    return {
    "latitude": latitude,
    "longitude": longitude,
    "temperature_c": current.get("temperature_2m"),
    "wind_speed_kt": current.get("windspeed_10m"),
    "wind_direction_deg": current.get("winddirection_10m"),
    "visibility_m": current.get("visibility"),
    "source": "open-meteo"
}

