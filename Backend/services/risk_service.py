from risk_engine.airport_profiles import AIRPORT_RISK_PROFILES


def assess_weather_risk(icao: str, normalized_weather: dict) -> dict:
    """
    Assess aviation weather risk using airport-specific operational factors.
    """

    profile = AIRPORT_RISK_PROFILES.get(icao)

   
    if not profile:
        profile = {
            "category": "VALLEY",
            "visibility_high_risk_km": 2,
            "cloud_ceiling_high_risk_ft": 1500,
            "wind_high_risk_kt": 20,
        }

    score = 0
    reasons = []

    visibility = normalized_weather.get("visibility_km")
    wind_speed = normalized_weather.get("wind_speed_kt")
    wind_dir = normalized_weather.get("wind_direction_deg")
    cloud_ceiling = normalized_weather.get("cloud_ceiling_ft")
    conditions = normalized_weather.get("conditions", [])

    # -------------------------
    # VISIBILITY (Airport-aware)
    # -------------------------
    if visibility is not None:
        if visibility < profile["visibility_high_risk_km"]:
            score += 3
            reasons.append(
                f"Visibility below {profile['visibility_high_risk_km']} km"
            )

    # -------------------------
    # CLOUD CEILING
    # -------------------------
    if cloud_ceiling is not None:
        if cloud_ceiling < profile["cloud_ceiling_high_risk_ft"]:
            score += 3
            reasons.append(
                f"Cloud ceiling below {profile['cloud_ceiling_high_risk_ft']} ft"
            )
    
    lowest_cloud = normalized_weather.get("lowest_cloud_base_ft")

    if cloud_ceiling is None and lowest_cloud is not None:
        if profile["category"] in ["MOUNTAIN", "VALLEY"] and lowest_cloud < 2000:
            score += 1
        reasons.append(
            f"Low cloud base at {lowest_cloud} ft (terrain risk)"
        )


    # -------------------------
    # WIND
    # -------------------------
    if wind_speed is not None:
        if wind_speed >= profile["wind_high_risk_kt"]:
            score += 2
            reasons.append(
                f"Strong wind: {wind_speed} kt from {wind_dir}°"
            )

    # -------------------------
    # WEATHER PHENOMENA
    # -------------------------
    if "FG" in conditions:
        score += 2
        reasons.append("Fog reported")

    if "TS" in conditions:
        score += 3
        reasons.append("Thunderstorm activity")

    if "SN" in conditions:
        score += 2
        reasons.append("Snowfall reported")

    if "RA" in conditions:
        score += 1
        reasons.append("Rain reported")

    # -------------------------
    # AIRPORT CATEGORY PENALTY
    # -------------------------
    if profile["category"] == "MOUNTAIN":
        score += 1
        reasons.append("Mountain airport operations")

    # -------------------------
    # FINAL RISK LEVEL
    # -------------------------
    if score >= 7:
        risk_level = "HIGH"
    elif score >= 4:
        risk_level = "MODERATE"
    else:
        risk_level = "LOW"

    return {
        "icao": icao,
        "airport_category": profile["category"],
        "risk_level": risk_level,
        "risk_score": score,
        "reasons": reasons,
        "wind": {
            "speed_kt": wind_speed,
            "direction_deg": wind_dir,
        },
        "weather": normalized_weather, 
    }
