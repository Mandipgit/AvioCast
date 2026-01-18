from fastapi import APIRouter, HTTPException
from services.checkwx_services import get_metar
from services.open_meteo_service import get_forecast_weather
from database.models.airport import AIRPORTS

router = APIRouter(
    prefix="/weather",
    tags=["Weather"]
)


@router.get("/{icao_code}")
def fetch_weather(icao_code: str):
    icao_code = icao_code.upper()

    airport = AIRPORTS.get(icao_code)
    if not airport:
        raise HTTPException(status_code=404, detail="Unknown airport code")

    #  METAR 
    metar_data = get_metar(icao_code)
    if metar_data:
        return metar_data

    #  Second Option for forecast
    return get_forecast_weather(
        latitude = airport.latitude,
        longitude = airport.longitude

    )
