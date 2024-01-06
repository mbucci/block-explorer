from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    INFURA_API_KEY: str
    INFURA_BASE_URL: str
