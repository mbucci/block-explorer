import os
import logging
import json
from typing import Tuple

from web3 import Web3, exceptions

from app.errors import BadRequest, NotFound
from app.settings import Settings


INFURA_URL = os.path.join(Settings().INFURA_BASE_URL, Settings().INFURA_API_KEY)

log = logging.getLogger(__name__)
web3 = Web3(Web3.HTTPProvider(INFURA_URL))


def get_ethereum_balance(address: str) -> Tuple[float, int]:
    try:
        address = web3.to_checksum_address(address)
    except exceptions.InvalidAddress as e:
        msg = f"Invalid address: {address}"

        log.exception(msg)
        raise NotFound(msg) from e

    except ValueError as e:
        msg = f"Bad address: {address}"

        log.exception(msg)
        raise BadRequest(msg) from e

    balanceWei = web3.eth.get_balance(address)
    balanceEth = Web3.from_wei(balanceWei, "ether")

    return balanceEth, balanceWei


def get_ethereum_txn(txn_hash: str) -> dict:
    try:
        txn = web3.eth.get_transaction(txn_hash)

        return json.loads(Web3.to_json(txn))

    except exceptions.TransactionNotFound as e:
        msg = f"Invalid txn: {txn_hash}"

        log.exception(msg)
        raise NotFound(msg) from e
