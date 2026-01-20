📄 File-by-File Explanation (Beginner Friendly)
main.py

Entry point of the backend

Creates FastAPI app

Registers routers

settings.py

Stores configuration and secrets

API keys and base URLs

Prevents hard-coding sensitive data

database/models/airport.py

Contains all Nepali airports

Stores:

ICAO / IATA

Coordinates

METAR availability

Alternate airports

services/checkwx_services.py

Fetches METAR weather

Uses CheckWX API

Returns raw aviation weather text

services/open_meteo_service.py

Fetches forecast weather

Used when METAR is unavailable

Provides wind, temperature, visibility

services/weather_normalizer.py

Converts raw weather into a common format

Extracts:

Wind

Visibility

Cloud ceiling

Weather conditions

Makes METAR and forecast data comparable

risk_engine/airport_profiles.py

Defines airport difficulty profiles

Different thresholds for:

Mountain airports

Valley airports

Nepal-specific tuning

services/risk_service.py

Core decision engine

Calculates risk score using:

Visibility

Cloud ceiling

Wind

Weather phenomena

Airport category

Outputs LOW / MODERATE / HIGH risk

routers/weather.py

Public API endpoints

Combines all services

Returns:

Destination risk

Alternate airport risks (optional)

🔄 How Data Flows (Simple Explanation)

Frontend calls API

/weather/risk/VNKT?include_alternates=true


Router validates airport

Reads airport info & alternates

Weather fetched

METAR → CheckWX

Else → Open-Meteo

Weather normalized

Converted into aviation fields

Risk calculated

Airport-specific rules applied

Response returned

JSON sent to Flutter app

📡 API Endpoint
Get Weather Risk
GET /weather/risk/{icao}

Query Parameters
Name	Type	Description
include_alternates	bool	Include alternate airports
Example Response
{
  "destination": {
    "icao": "VNKT",
    "weather": {...},
    "risk": {
      "risk_level": "LOW",
      "risk_score": 1
    }
  },
  "alternates": [
    {
      "icao": "VNBW",
      "weather": {...},
      "risk": {...}
    }
  ]
}

▶️ How to Run Locally
python -m venv acenv
acenv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload


Open:

http://127.0.0.1:8000/docs
