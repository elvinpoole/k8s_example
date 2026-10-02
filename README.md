# k8s_example

Example of running Python code with Kubernetes.

`kubernetes` (k8s) - System for automating deployment of containers

`kind` - Kubernetes in docker - runs docker containers that act like kubernetes nodes. Useful if you want to test kubernetes jobs on your local machine without having to install anything complicated 

`helm` - Package manager for kubernetes - when you have too many kubernetes yaml files to keep track of, use helm.

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
│   ├── HELM_HOWTO.md     # Helm guide
│   └── hello-world/      # Educational Helm chart
├── Dockerfile
└── pyproject.toml
```

## Usage

```bash
pip install -e ".[dev]"   # install app
hello-world               # cli for app that just prints hello world
pytest                    # run the tests
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
kubectl wait --for=condition=complete job/my-hello-world-job --timeout=60s
kubectl logs job/my-hello-world-job  

# 5. Clean up the Job and delete the cluster
kubectl delete -f k8s/job.yaml
kind delete cluster --name k8s-example
```

Expected log output: `Hello, world!`

## Run with Helm (kind)

Same image and Job as above, packaged with helm. Full walkthrough: [helm/HELM_HOWTO.md](helm/HELM_HOWTO.md).

Prerequisites: also install [Helm](https://helm.sh/docs/intro/install/).

Note steps 1, 2 and 4 are identical to the k8s example above

```bash
# 1. Create a local cluster (once)
kind create cluster --name k8s-example   # if needed

# 2. Build the image and load it into kind
docker build -t hello-world:local .
kind load docker-image hello-world:local --name k8s-example

# 3. Run the Job
helm install hello-world ./helm/hello-world -f ./helm/hello-world/values-local.yaml

# 4. Wait for completion and read the logs
kubectl wait --for=condition=complete job/hello-world --timeout=60s
kubectl logs job/hello-world

# 5. uninstall the app and delete the cluster
helm uninstall hello-world
kind delete cluster --name k8s-example
```

Alternatively you can run `helm upgrade --install` to update an existing install (acts the same as `helm install` if the release does not exist yet) but note this will not re-run any jobs directly.

General helm command:
`helm upgrade --install <name of the release> <location of the charts> -f <values file>`

