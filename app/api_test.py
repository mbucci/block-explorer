def test_app(test_client):
    response = test_client.client.get("/")

    assert response.status_code == 200
