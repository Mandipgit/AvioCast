from risk_engine.alternate_airports import ALTERNATE_AIRPORTS
from services.risk_service import assess_weather_risk


def compare_with_alternates(
    destination_weather: dict,
    alternate_weathers: list[dict]
) -> dict:
    """
    Compare destination risk with alternate airports.
    """

    # Assess destination risk
    destination_risk = assess_weather_risk(destination_weather)

    destination_score = destination_risk["risk_score"]

    comparisons = []
    recommended_alternate = None

    # Assess alternates
    for alt_weather in alternate_weathers:
        alt_risk = assess_weather_risk(alt_weather)

        comparison = {
            "icao": alt_risk["icao"],
            "risk_level": alt_risk["risk_level"],
            "risk_score": alt_risk["risk_score"],
            "reasons": alt_risk["reasons"],
            "wind": alt_risk["wind"],
            "better_than_destination": False
        }

        # Compare risk score
        if alt_risk["risk_score"] < destination_score:
            comparison["better_than_destination"] = True

            # Select best alternate (lowest score wins)
            if (
                recommended_alternate is None or
                alt_risk["risk_score"] < recommended_alternate["risk_score"]
            ):
                recommended_alternate = comparison

        comparisons.append(comparison)

    return {
        "destination": destination_risk,
        "alternates": comparisons,
        "recommended_alternate": recommended_alternate
    }
