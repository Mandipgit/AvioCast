from fastapi import APIRouter, HTTPException

from database.models.airport import AIRPORTS
from services.checkwx_services import get_metar
from services.open_meteo_service import get_forecast_weather
from services.weather_normalizer import normalize_weather
from services.risk_service import assess_weather_risk   

router = APIRouter(
    prefix="/weather",
    tags=["Weather"]
)


@router.get("/{icao_code}")
def get_weather(icao_code: str):
    icao = icao_code.upper()

    # airport ko validation
    airport = AIRPORTS.get(icao)
    if not airport:
        raise HTTPException(status_code=404, detail="Airport not found")

    raw_weather = None

    # Try METAR first
    metar_data = get_metar(icao)
    if metar_data and "raw_metar" in metar_data:
        raw_weather = {
            "source": "checkwx",
            "provider_response": metar_data
        }
        weather_payload = {
            **metar_data,
            "source": "checkwx"
        }

    # Option-1 fail vayesi fallback option for open meteo
    else:
        forecast_data = get_forecast_weather(
            latitude=airport.latitude,
            longitude=airport.longitude
        )

        raw_weather = {
            "source": "open-meteo",
            "provider_response": forecast_data.get("raw")
        }

        weather_payload = forecast_data

    # Normalize weather 
    normalized_weather = normalize_weather(icao, weather_payload)

    # Risk assessment 
    risk_result = assess_weather_risk(normalized_weather)

    # Last ko professional response
    return {
        "icao": icao,
        "airport": {
            "name": airport.name,
            "iata": airport.iata
        },
        "weather": normalized_weather,
        "risk": risk_result,
        "raw": raw_weather
    }
