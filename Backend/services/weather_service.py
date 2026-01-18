from database.models.airport import AIRPORTS
from services.checkwx_services import get_metar
from services.open_meteo_service import get_forecast_weather


def get_weather(icao_code: str) -> dict:
    """
    Decide weather source based on airport capability.
    """
    airport = AIRPORTS.get(icao_code.upper())

    if not airport:
        return {
            "error": "Unknown airport"
        }

    # METAR
    if airport.has_metar is True:
        metar_data = get_metar(airport.icao)

        if "raw_metar" in metar_data:
            return {
                "airport": airport.icao,
                "iata": airport.iata,
                "source": "METAR",
                "raw_metar": metar_data["raw_metar"]
            }

    # Second Option: Forecast model
    forecast = get_forecast_weather(
        latitude=airport.latitude,
        longitude=airport.longitude
    )

    return {
        "airport": airport.icao,
        "iata": airport.iata,
        "source": "FORECAST",
        "forecast": forecast
    }
