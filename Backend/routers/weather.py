from fastapi import APIRouter, Query
from services.checkwx_services import get_metar
from services.open_meteo_service import get_forecast_weather
from services.weather_normalizer import normalize_weather
from services.risk_service import assess_weather_risk
from database.models.airport import AIRPORTS

router = APIRouter(
    prefix="/weather",
    tags=["Weather"]
)

def fetch_weather_for_airport(icao: str):
    """
    Safely fetch and normalize weather for any airport.
    Returns a structured dict even if weather is unavailable.
    """
    airport = AIRPORTS.get(icao.upper())
    if not airport:
        return {"icao": icao.upper(), "error": "Airport not found"}

    # Fetch METAR first
    raw_weather = get_metar(icao.upper())
    if not raw_weather:
        # Fallback to Open-Meteo forecast
        raw_weather = get_forecast_weather(airport.latitude, airport.longitude)

    if not raw_weather:
        # Both sources failed
        return {"icao": icao.upper(), "error": "Weather data unavailable"}

    # Attempt normalization safely
    try:
        normalized = normalize_weather(icao.upper(), raw_weather)
    except ValueError:
        normalized = {
            "icao": icao.upper(),
            "error": "Could not normalize weather data",
            "raw": raw_weather
        }

    return normalized


@router.get("/risk/{icao}")
def get_weather_risk(
    icao: str,
    include_alternates: bool = Query(False, description="Include alternate airports?")
):
    """
    Fetch weather risk for a destination airport.
    Optionally include alternates with their weather data.
    """
    airport = AIRPORTS.get(icao.upper())
    if not airport:
        return {"error": f"Airport {icao.upper()} not found"}

    # -----------------------------
    # Destination Weather
    # -----------------------------
    normalized_weather = fetch_weather_for_airport(icao.upper())
    if "error" not in normalized_weather:
        dest_risk = assess_weather_risk(icao.upper(), normalized_weather)
    else:
        dest_risk = None

    response = {
        "destination": {
            "icao": icao.upper(),
            "weather": normalized_weather,
            "risk": dest_risk
        }
    }

    # -----------------------------
    # Alternate Airports
    # -----------------------------
    if include_alternates and getattr(airport, "alternates", None):
        alternates_list = []
        for alt_icao in airport.alternates:
            alt_weather = fetch_weather_for_airport(alt_icao)
            if "error" not in alt_weather:
                alt_risk = assess_weather_risk(alt_icao, alt_weather)
            else:
                alt_risk = None

            alternates_list.append({
                "icao": alt_icao,
                "weather": alt_weather,
                "risk": alt_risk
            })

        response["alternates"] = alternates_list

    return response
