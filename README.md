# Proyecto Procesos - Task API

API REST minima para gestion de tareas con FastAPI, Docker, CI/CD y despliegue en Kubernetes.

## Endpoints

- `GET /health`
- `GET /tasks`
- `POST /tasks`

## Ejecutar local

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt -r requirements-dev.txt
uvicorn app.main:app --reload
```

## Pruebas

```bash
pytest -q
```

## Docker

```bash
docker build -t task-api:latest .
docker run -p 8000:8000 task-api:latest
```

## Kubernetes (Minikube)

```bash
minikube start
eval $(minikube docker-env)
docker build -t task-api:latest .
kubectl apply -f k8s
minikube service task-api
```

## CI/CD

El workflow en `.github/workflows/ci.yml`:

- Build y tests
- SAST con Bandit
- Build de imagen Docker
- Deploy a Kubernetes si existe `KUBECONFIG` como secreto
