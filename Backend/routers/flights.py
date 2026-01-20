from fastapi import APIRouter, Query, HTTPException

from services.checkwx_services import get_metar
from services.open_meteo_service import get_forecast_weather
from services.weather_normalizer import normalize_weather
from services.risk_service import assess_weather_risk
from database.models.airport import AIRPORTS

router = APIRouter(
    prefix="/flight",
    tags=["Flight Prediction"]
)


@router.get("/prediction")
def predict_flight_possibility(
    origin: str = Query(..., description="Origin airport ICAO"),
    destination: str = Query(..., description="Destination airport ICAO"),
):
    """
    Predict flight possibility based on weather risk
    at both origin and destination airports.
    """

    origin = origin.upper()
    destination = destination.upper()

    origin_airport = AIRPORTS.get(origin)
    destination_airport = AIRPORTS.get(destination)

    if not origin_airport or not destination_airport:
        raise HTTPException(
            status_code=404,
            detail="One or more airports not found"
        )

    # -------------------------
    # FETCH WEATHER (METAR → FORECAST)
    # -------------------------
    origin_raw = get_metar(origin)
    if not origin_raw:
        origin_raw = get_forecast_weather(
            origin_airport.latitude,
            origin_airport.longitude
        )

    destination_raw = get_metar(destination)
    if not destination_raw:
        destination_raw = get_forecast_weather(
            destination_airport.latitude,
            destination_airport.longitude
        )

    if not origin_raw or not destination_raw:
        raise HTTPException(
            status_code=404,
            detail="Weather data not available for one or more airports"
        )

    # -------------------------
    # NORMALIZE WEATHER
    # -------------------------
    origin_weather = normalize_weather(origin, origin_raw)
    destination_weather = normalize_weather(destination, destination_raw)

    # -------------------------
    # ASSESS RISK
    # -------------------------
    origin_risk = assess_weather_risk(origin, origin_weather)
    destination_risk = assess_weather_risk(destination, destination_weather)

    # -------------------------
    # FLIGHT POSSIBILITY
    # -------------------------
    flight_prediction = calculate_flight_possibility(
        origin_risk["risk_level"],
        destination_risk["risk_level"]
    )

    return {
        "origin": {
            "icao": origin,
            "weather": origin_weather,
            "risk": origin_risk
        },
        "destination": {
            "icao": destination,
            "weather": destination_weather,
            "risk": destination_risk
        },
        "flight_prediction": flight_prediction
    }


def calculate_flight_possibility(origin_risk: str, destination_risk: str) -> dict:
    """
    Passenger-friendly flight possibility logic.
    """

    if origin_risk == "HIGH" or destination_risk == "HIGH":
        return {
            "level": "VERY LOW",
            "message": "Severe weather conditions. Flight likely to be cancelled."
        }

    if origin_risk == "MODERATE" and destination_risk == "MODERATE":
        return {
            "level": "LOW",
            "message": "Weather may cause delays or rescheduling."
        }

    if origin_risk == "LOW" and destination_risk == "MODERATE":
        return {
            "level": "MODERATE",
            "message": "Flight is possible but minor delays are expected."
        }

    if origin_risk == "LOW" and destination_risk == "LOW":
        return {
            "level": "HIGH",
            "message": "Weather conditions are favorable for flight."
        }

    return {
        "level": "UNKNOWN",
        "message": "Unable to determine flight possibility."
    }
