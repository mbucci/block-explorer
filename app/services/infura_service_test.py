import pytest

from unittest.mock import patch

from app.services import infura_service


@patch.object(infura_service.web3, "eth")
class TestInfuraService:
    def test_get_ethereum_balance(self, mock_web3_eth, test_eth_address):
        mock_web3_eth.get_balance.return_value = 1234e18  # 1234 wei

        eth, _ = infura_service.get_ethereum_balance(test_eth_address)

        assert eth == 1234

    def test_get_ethereum_balance_bad_address(self, mock_web3_eth):
        with pytest.raises(infura_service.BadRequest):
            infura_service.get_ethereum_balance("bad")

        mock_web3_eth.assert_not_called()
