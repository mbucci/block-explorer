from unittest.mock import patch

from app.errors import BadRequest, NotFound, BlockExplorerException


@patch("app.api.router.infura_service")
class TestErrorHandlers:
    def test_bad_request(self, mock_infura_svc, test_client):
        mock_infura_svc.get_ethereum_balance.side_effect = BadRequest("Bad Address")

        response = test_client.get(f"/api/chains/eth/blah/balance")

        assert response.status_code == 400

        response_json = response.json()

        assert response_json["error"] == "Bad Address"

    def test_not_found(self, mock_infura_svc, test_client):
        mock_infura_svc.get_ethereum_balance.side_effect = NotFound("Not Found")

        response = test_client.get(f"/api/chains/eth/blah/balance")

        assert response.status_code == 404

        response_json = response.json()

        assert response_json["error"] == "Not Found"

    def test_base_exception(self, mock_infura_svc, test_client):
        mock_infura_svc.get_ethereum_balance.side_effect = BlockExplorerException(
            "exception"
        )

        response = test_client.get(f"/api/chains/eth/blah/balance")

        assert response.status_code == 500

        response_json = response.json()

        assert response_json["error"] == "exception"


@patch("app.api.router.infura_service")
class TestChainsAPIEth:
    def test_get_balance(self, mock_infura_svc, test_client):
        mock_infura_svc.get_ethereum_balance.return_value = 123

        response = test_client.get(f"/api/chains/eth/blah/balance")

        assert response.status_code == 200

        response_json = response.json()

        assert response_json["balance"] >= 0
