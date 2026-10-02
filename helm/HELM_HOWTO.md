# hello-world Helm Chart Guide

Educational Helm chart that mirrors the **structure** of the [FASTDB Helm chart](https://github.com/CanDIAPL/FASTDB/tree/helm/helm/fastdb), but only deploys our simple Job.

## What is Helm?

Helm is a package manager for Kubernetes. A **chart** is a package of templated Kubernetes manifests. Think of it like `pip`/`brew`, but for cluster resources.

```
templates + values  →  helm  →  plain Kubernetes YAML  →  cluster
```

## Chart layout (vs FASTDB)

```
helm/hello-world/
├── Chart.yaml              # Chart metadata (name, version)
├── values.yaml             # Default configuration values
├── values-local.yaml       # Local Kind cluster overrides
└── templates/              # Kubernetes manifest templates
    ├── _helpers.tpl        # Reusable template functions
    └── job.yaml            # Job (like FASTDB's createdb-job.yaml)
```

| This repo | FASTDB analogue |
|---|---|
| `Chart.yaml` | `helm/fastdb/Chart.yaml` |
| `values.yaml` | defaults for all environments |
| `values-local.yaml` | Kind overrides (`imagePullPolicy: Never`, etc.) |
| `_helpers.tpl` | shared name / label / image helpers |
| `templates/job.yaml` | one-shot Job like `createdb-job.yaml` |

We intentionally omit postgres, secrets, PVCs, namespaces, and SLAC values — those are FASTDB-scale. The packaging pattern is the same.

## Plain YAML vs Helm

| Approach | Path | When to use |
|---|---|---|
| Plain manifest | `k8s/job.yaml` | Learn the raw Job object |
| Helm chart | `helm/hello-world/` | Same Job, parameterized like FASTDB |

## Deploy to Kind

Prerequisites: Docker, kind, kubectl, and [Helm](https://helm.sh/docs/intro/install/).

```bash
# 1. Create a local cluster (once), if needed
kind create cluster --name k8s-example

# 2. Build the image and load it into kind
docker build -t hello-world:local .
kind load docker-image hello-world:local --name k8s-example

# 3. Install the chart with local overrides
helm install hello-world ./helm/hello-world -f ./helm/hello-world/values-local.yaml

# 4. Wait and read logs
kubectl wait --for=condition=complete job/my-hello-world-job-helm --timeout=60s
kubectl logs job/my-hello-world-job-helm

# 5. Clean up the release (or delete the cluster)
helm uninstall hello-world
kind delete cluster --name k8s-example
```

Expected log output: `Hello, world!`

### Preview rendered YAML (no cluster required)

```bash
helm template hello-world ./helm/hello-world -f ./helm/hello-world/values-local.yaml
```

This prints the Job Kubernetes would receive — useful for comparing with `k8s/job.yaml`.
