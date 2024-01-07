def test_eth_balance(test_client, test_eth_address):
    response = test_client.get(f"/api/chains/eth/{test_eth_address}/balance")

    assert response.status_code == 200

    response_json = response.json()

    assert response_json["balance"] >= 0
