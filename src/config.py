from typing import Any
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    app_name: str = "Weather Forecast API"
    VERSION: str
    openweather_api_key: str = ''
    redis_url: str = "redis://redis:6379/0"
    cache_ttl: int = 3600  # 1 час в секундах

    class Config:
        env_file = ".env"

settings = Settings()

description = """
Weather Service for aggregation
"""
app_config: dict[str, Any] = {
    "title": settings.app_name,
    "version": settings.VERSION,
    "description": description,
}