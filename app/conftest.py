from pytest import fixture
from fastapi.testclient import TestClient


@fixture
def test_client():
    from app.api import app

    return TestClient(app)
