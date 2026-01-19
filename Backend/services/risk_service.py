def assess_weather_risk(normalized_weather: dict) -> dict:
    """
    Assess aviation weather risk using multiple operational factors.
    """

    score = 0
    reasons = []

    visibility = normalized_weather.get("visibility_km")
    wind_speed = normalized_weather.get("wind_speed_kt")
    wind_dir = normalized_weather.get("wind_direction_deg")
    cloud_ceiling = normalized_weather.get("cloud_ceiling_ft")
    conditions = normalized_weather.get("conditions", [])

    # -------------------------
    # Visibility Risk
    # -------------------------
    if visibility is not None:
        if visibility < 1:
            score += 3
            reasons.append("Visibility below 1 km")
        elif visibility < 3:
            score += 2
            reasons.append("Visibility between 1–3 km")
        elif visibility < 5:
            score += 1
            reasons.append("Visibility between 3–5 km")

    # -------------------------
    # Wind Risk (speed-based)
    # -------------------------
    if wind_speed is not None:
        if wind_speed > 25:
            score += 3
            reasons.append(f"Strong wind: {wind_speed} kt from {wind_dir}°")
        elif wind_speed > 15:
            score += 2
            reasons.append(f"Moderate wind: {wind_speed} kt from {wind_dir}°")
        elif wind_speed > 10:
            score += 1

    # -------------------------
    # Cloud Ceiling Risk
    # -------------------------
    if cloud_ceiling is not None:
        if cloud_ceiling < 500:
            score += 3
            reasons.append("Cloud ceiling below 500 ft")
        elif cloud_ceiling < 1000:
            score += 2
            reasons.append("Cloud ceiling below 1000 ft")
        elif cloud_ceiling < 2000:
            score += 1

    # -------------------------
    # Weather Phenomena Risk
    # -------------------------
    for wx in conditions:
        if wx in ["TS", "SN", "FG"]:
            score += 3
            reasons.append(f"Severe weather reported: {wx}")
        elif wx in ["RA", "BR"]:
            score += 1
            reasons.append(f"Weather condition reported: {wx}")

    # -------------------------
    # Final Risk Classification
    # -------------------------
    if score >= 6:
        risk_level = "HIGH"
    elif score >= 3:
        risk_level = "MODERATE"
    else:
        risk_level = "LOW"

    return {
        "icao": normalized_weather.get("icao"),
        "risk_level": risk_level,
        "risk_score": score,
        "reasons": reasons,
        "wind": {
            "speed_kt": wind_speed,
            "direction_deg": wind_dir
        }
    }
