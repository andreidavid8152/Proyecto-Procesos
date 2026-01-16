from fastapi import FastAPI

from .models import Task, TaskCreate
from .store import store

app = FastAPI(title="Task API", version="1.0.0")


@app.get("/health")
def health() -> dict:
    return {"status": "ok"}


@app.get("/tasks", response_model=list[Task])
def list_tasks() -> list[Task]:
    return store.list_tasks()


@app.post("/tasks", response_model=Task, status_code=201)
def create_task(payload: TaskCreate) -> Task:
    return store.create_task(payload)
