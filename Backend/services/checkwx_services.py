import requests
from config.settings import settings


def get_metar(icao_code: str) -> dict:
    """
    Fetch raw METAR data for a given ICAO airport code from CHECKWX.
    """

    url = f"{settings.CHECKWX_BASE_URL}/metar/{icao_code}"

    headers = {
        "X-API-Key": settings.CHECKWX_API_KEY
    }

    try:
        response = requests.get(
            url=url,
            headers=headers,
            timeout=settings.HTTP_TIMEOUT
        )

        # If CHECKWX responds but with an error
        if response.status_code != 200:
            return None

        data = response.json()

        # CHECKWX returns METAR inside a list
        metar_list = data.get("data", [])

        if not metar_list:
            return None

        return {
            "icao": icao_code,
            "raw_metar": metar_list[0]
        }

    except requests.exceptions.Timeout:
        return None

    except requests.exceptions.RequestException as e:
        return None
