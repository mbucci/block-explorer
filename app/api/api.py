import logging

from app.services import infura_service

from fastapi import APIRouter

router = APIRouter(prefix="/api")


log = logging.getLogger(__name__)


@router.get("/chains/eth/{address}/balance")
def chains_eth_get_balance(address: str):
    balance = infura_service.get_ethereum_balance(address=address)

    return {"balance": balance}
