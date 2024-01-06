import logging
from datetime import datetime

from app.settings import Settings
from app.services import infura_service

from fastapi import FastAPI

app = FastAPI()


log = logging.getLogger()
log.setLevel(logging.DEBUG)


log.warning(Settings().INFURA_API_KEY)


@app.get("/health")
def health_check():
    return {"timestamp": datetime.now().isoformat()}


@app.get("/chains/ethereum/{address}/balance")
def chains_eth_get_balance(address: str):
    balance = infura_service.get_ethereum_balance(address=address)

    return {"balance": balance}
