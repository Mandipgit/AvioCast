def normalize_weather(icao: str, weather_data: dict) -> dict:
    """
    Normalize METAR or forecast weather into a common aviation schema.
    """

    source = weather_data.get("source")

    if source == "checkwx":
        return _normalize_metar(icao, weather_data)

    if source == "open-meteo":
        return _normalize_forecast(icao, weather_data)

    raise ValueError("Unknown weather source")


import re


def _normalize_metar(icao: str, data: dict) -> dict:
    raw_metar = data.get("raw_metar", "")

    wind_speed = None
    wind_dir = None
    visibility_km = None
    cloud_ceiling_ft = None
    conditions = []
    temperature_c = None

    # WIND 
    wind_match = re.search(r"(\d{3})(\d{2})KT", raw_metar)
    if wind_match:
        wind_dir = int(wind_match.group(1))
        wind_speed = int(wind_match.group(2))

    #VISIBILITY 
    vis_match = re.search(r"\s(\d{4})\s", raw_metar)
    if vis_match:
        visibility_km = int(vis_match.group(1)) / 1000

    # CLOUD CEILING (BKN / OVC only) 
    cloud_match = re.search(r"(BKN|OVC)(\d{3})", raw_metar)
    if cloud_match:
        cloud_ceiling_ft = int(cloud_match.group(2)) * 100

    #  WEATHER CONDITIONS 
    for wx in ["TS", "RA", "SN", "FG", "BR"]:
        if wx in raw_metar:
            conditions.append(wx)

    # TEMPERATURE (18/12) 
    temp_match = re.search(r"(\d{2})/\d{2}", raw_metar)
    if temp_match:
        temperature_c = int(temp_match.group(1))

    return {
        "icao": icao,
        "source": "metar",
        "wind_speed_kt": wind_speed,
        "wind_direction_deg": wind_dir,
        "visibility_km": visibility_km,
        "cloud_ceiling_ft": cloud_ceiling_ft,
        "temperature_c": temperature_c,
        "conditions": conditions,
        "raw": raw_metar
    }



def _normalize_forecast(icao: str, data: dict) -> dict:
    visibility_m = data.get("visibility_m")

    return {
        "icao": icao,
        "source": "forecast",
        "wind_speed_kt": data.get("wind_speed_kt"),
        "wind_direction_deg": data.get("wind_direction_deg"),
        "temperature_c": data.get("temperature_c"),
        "visibility_km": round(visibility_m / 1000, 1) if visibility_m else None,
        "cloud_ceiling_ft": None,
        "conditions": [],
        "raw": data
    }

