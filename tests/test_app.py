from fastapi.testclient import TestClient

from app.main import app
from app.store import store


def setup_function() -> None:
    store.reset()


def test_health() -> None:
    client = TestClient(app)
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_get_tasks_empty() -> None:
    client = TestClient(app)
    response = client.get("/tasks")

    assert response.status_code == 200
    assert response.json() == []


def test_create_task() -> None:
    client = TestClient(app)
    response = client.post("/tasks", json={"title": "Buy milk", "description": "2 liters"})

    assert response.status_code == 201
    assert response.json()["id"] == 1
    assert response.json()["title"] == "Buy milk"

    response = client.get("/tasks")
    assert response.status_code == 200
    assert len(response.json()) == 1
