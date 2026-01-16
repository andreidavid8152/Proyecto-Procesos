from dataclasses import dataclass, field
from typing import List, Optional

from .models import Task, TaskCreate


@dataclass
class InMemoryTaskStore:
    tasks: List[Task] = field(default_factory=list)
    next_id: int = 1

    def list_tasks(self) -> List[Task]:
        return list(self.tasks)

    def create_task(self, payload: TaskCreate) -> Task:
        task = Task(id=self.next_id, title=payload.title, description=payload.description)
        self.tasks.append(task)
        self.next_id += 1
        return task

    def reset(self) -> None:
        self.tasks = []
        self.next_id = 1


store = InMemoryTaskStore()
