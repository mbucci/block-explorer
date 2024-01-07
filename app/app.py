import logging
from datetime import datetime

from app.api.api import router

from fastapi import FastAPI

app = FastAPI()

log = logging.getLogger()


@app.get("/health")
def health_check():
    return {"timestamp": datetime.now().isoformat()}


app.include_router(router)
