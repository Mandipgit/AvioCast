from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routers.weather import router as weather_router
from routers.flights import router as flights_router
from routers.airports import router as airports_router

app = FastAPI(
    title="Aviation Weather Awareness API",
    description="Backend API for aviation weather awareness and risk estimation for Nepal",
    version="0.1.0",
)

# -------------------------
# ROUTERS
# -------------------------
app.include_router(weather_router)
app.include_router(flights_router)
app.include_router(airports_router)

# -------------------------
# CORS
# -------------------------
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# -------------------------
# ROOT CHECK
# -------------------------
@app.get("/")
def greet():
    return "Hello to the new world baby"
