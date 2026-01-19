from fastapi import APIRouter, HTTPException, Query

from database.models.airport import AIRPORTS
from services.open_meteo_service import get_forecast_weather
from services.weather_normalizer import normalize_weather
from services.risk_service import assess_weather_risk
from risk_engine.alternate_airports import ALTERNATE_AIRPORTS
from services.alternate_risk_comparator import compare_with_alternates

router = APIRouter(prefix="/weather", tags=["Weather Risk"])


@router.get("/risk/{icao}")
def get_weather_risk(
    icao: str,
    include_alternates: bool = Query(default=False)
):
    icao = icao.upper()

    # -------------------------
    # Validate destination
    # -------------------------
    airport = AIRPORTS.get(icao)
    if not airport:
        raise HTTPException(status_code=404, detail="Airport not found")

    # -------------------------
    # Destination weather
    # -------------------------
    raw_weather = get_forecast_weather(
        airport.latitude,
        airport.longitude
    )

    normalized_weather = normalize_weather(icao, raw_weather)

    # -------------------------
    # No alternates requested
    # -------------------------
    if not include_alternates:
        risk = assess_weather_risk(normalized_weather)
        return {
            "airport": airport.name,
            "icao": icao,
            "weather": normalized_weather,
            "risk": risk
        }

    # -------------------------
    # Fetch alternate weathers
    # -------------------------
    alternate_weathers = []

    for alt_icao in ALTERNATE_AIRPORTS.get(icao, []):
        alt_airport = AIRPORTS.get(alt_icao)
        if not alt_airport:
            continue

        alt_raw = get_forecast_weather(
            alt_airport.latitude,
            alt_airport.longitude
        )

        alt_normalized = normalize_weather(alt_icao, alt_raw)
        alternate_weathers.append(alt_normalized)

    # -------------------------
    # Compare risks
    # -------------------------
    comparison = compare_with_alternates(
        destination_weather=normalized_weather,
        alternate_weathers=alternate_weathers
    )

    return {
        "airport": airport.name,
        "icao": icao,
        "comparison": comparison
    }
