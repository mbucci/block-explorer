from pytest import fixture
from fastapi.testclient import TestClient

from app.app import app


@fixture
def test_client():
    return TestClient(app)


@fixture
def test_eth_address():
    return "0x1E2cD78882b12d3954a049Fd82FFD691565dC0A5"
