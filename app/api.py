import logging
from typing import Union

from app.settings import Settings
from app.services import infura_service

from fastapi import FastAPI

app = FastAPI()


log = logging.getLogger()
log.setLevel(logging.DEBUG)


log.warning(Settings().INFURA_API_KEY)


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/{blah}")
def read_root(blah: str):
    log.info(blah)
    log.info("HELLo")
    return {"Hello": f"{blah}"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}


@app.get("/chains/ethereum/{address}/balance")
def chains_eth_get_balance(address: str):
    balance = infura_service.get_ethereum_balance(address=address)

    return {"balance": balance}
