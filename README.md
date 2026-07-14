# k8s_example

Example of running Python code with Kubernetes. Based on the candiamazing template.

## Layout

```
k8s_example/
├── src/hello_world/
│   ├── __init__.py
│   ├── cli.py
│   ├── core.py
│   └── test.py
├── tests/
├── docs/
├── k8s/
│   └── job.yaml          # Plain Kubernetes Job manifest
├── helm/
│   ├── HELM_HOWTO.md     # Helm guide (FASTDB-style layout)
│   └── hello-world/      # Educational Helm chart
├── Dockerfile
└── pyproject.toml
```

## Usage

```bash
pip install -e ".[dev]"
python src/hello_world/cli.py
pytest
```

## Run with Kubernetes (kind)

Prerequisites: [Docker](https://docs.docker.com/get-docker/), [kind](https://kind.sigs.k8s.io/), and [kubectl](https://kubernetes.io/docs/tasks/tools/).

```bash
# 1. Create a local cluster (once)
kind create cluster --name k8s-example

# 2. Build the image and load it into kind
docker build -t hello-world:local .
kind load docker-image hello-world:local --name k8s-example

# 3. Run the Job
kubectl apply -f k8s/job.yaml

# 4. Wait for completion and read the logs
kubectl wait --for=condition=complete job/hello-world --timeout=60s
kubectl logs job/hello-world

# 5. Clean up the Job (optional) or delete the cluster
kubectl delete -f k8s/job.yaml
kind delete cluster --name k8s-example
```

Expected log output: `Hello, world!`

## Run with Helm (kind)

Same image and Job as above, packaged like FASTDB (`values.yaml` + `values-local.yaml` + templates). Full walkthrough: [helm/HELM_HOWTO.md](helm/HELM_HOWTO.md).

Prerequisites: also install [Helm](https://helm.sh/docs/intro/install/).

```bash
kind create cluster --name k8s-example   # if needed
docker build -t hello-world:local .
kind load docker-image hello-world:local --name k8s-example

helm install hello-world ./helm/hello-world -f ./helm/hello-world/values-local.yaml
kubectl wait --for=condition=complete job/hello-world --timeout=60s
kubectl logs job/hello-world

helm uninstall hello-world
```
