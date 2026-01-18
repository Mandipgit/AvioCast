from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    # App
    APP_ENV: str = "development"

    # Open-Meteo
    WEATHER_API_BASE_URL: str = "https://api.open-meteo.com/v1/forecast"

    # HTTP
    HTTP_TIMEOUT: int = 10

    # CHECKWX (Aviation)
    CHECKWX_API_KEY: str
    CHECKWX_BASE_URL: str = "https://api.checkwx.com"

    class Config:
        env_file = ".env"


settings = Settings()
