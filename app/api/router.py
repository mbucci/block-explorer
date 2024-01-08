import logging

from app.services import infura_service

from fastapi import APIRouter

router = APIRouter(prefix="/api")


log = logging.getLogger(__name__)


@router.get("/chains/eth/{address}/balance", tags=["chains"])
def chains_eth_get_balance(address: str):
    """Get Balance in Eth and Wei for the given address"""

    [eth, wei] = infura_service.get_ethereum_balance(address=address)

    return {"balance": {"eth": eth, "wei": wei}}
