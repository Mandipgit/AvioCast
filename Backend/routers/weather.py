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


@router.get("/{icao}")
def fetch_weather_and_risk(icao: str):
    """
    Fetch aviation weather and assess flight risk for a given ICAO airport.
    """

    icao = icao.upper()

    # -------------------------
    # 1️⃣ Airport lookup
    # -------------------------
    airport = AIRPORTS.get(icao)
    if not airport:
        raise HTTPException(
            status_code=404,
            detail="Airport not found"
        )

    # -------------------------
    # 2️⃣ Try METAR first
    # -------------------------
    metar_data = get_metar(icao)

    if metar_data and "raw_metar" in metar_data:
        normalized_weather = normalize_weather(icao, {
            "source": "checkwx",
            **metar_data
        })

    else:
        # -------------------------
        # 3️⃣ Fallback to Open-Meteo
        # -------------------------
        forecast_data = get_forecast_weather(
            latitude=airport.latitude,
            longitude=airport.longitude
        )

        normalized_weather = normalize_weather(icao, {
            "source": "open-meteo",
            **forecast_data
        })

    # -------------------------
    # 4️⃣ Risk assessment
    # -------------------------
    risk_result = assess_weather_risk(icao, normalized_weather)

    # -------------------------
    # 5️⃣ Final response
    # -------------------------
    return {
        "airport": {
            "icao": airport.icao,
            "name": airport.name,
            "latitude": airport.latitude,
            "longitude": airport.longitude
        },
        "risk": risk_result,
    }
