import logging
from typing import Union

from fastapi import FastAPI

app = FastAPI()


log = logging.getLogger()
log.setLevel(logging.DEBUG)


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
