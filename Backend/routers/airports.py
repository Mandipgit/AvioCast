from fastapi import APIRouter
from database.models.airport import AIRPORTS
router = APIRouter(prefix="/airports", tags=["Airports"])


@router.get("/")
def get_all_airports():
    """
    Return list of all supported airports.
    """
    return {
        "count": len(AIRPORTS),
        "airports": AIRPORTS,
    }