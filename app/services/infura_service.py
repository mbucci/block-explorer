import os
import logging

from web3 import Web3, exceptions

from app.settings import Settings


INFURA_URL = os.path.join(Settings().INFURA_BASE_URL, Settings().INFURA_API_KEY)

log = logging.getLogger(__name__)
web3 = Web3(Web3.HTTPProvider(INFURA_URL))


def get_ethereum_balance(address: str) -> float:
    try:
        address = web3.to_checksum_address(address)
    except exceptions.InvalidAddress:
        log.exception(f"Invalid address: {address}")

    balanceWei = web3.eth.get_balance(address)
    balanceEth = Web3.from_wei(balanceWei, "ether")

    return balanceEth
