# Local Kubernetes Cluster

This repository provides scripts to easily create and manage local Kubernetes clusters using either **kind** or **k3d**. It’s designed for development and testing purposes where you want a lightweight Kubernetes environment on your local machine.

---

## Why do we want local Kubernetes clusters?

Local Kubernetes clusters allow developers to:

- 🚀 Quickly spin up a full Kubernetes environment without cloud provider dependencies.
- 🧪 Test containerized applications in an environment closely resembling production.
- ⚡ Iterate rapidly with fast cluster setup and teardown.
- 🔒 Experiment with Kubernetes resources and configurations safely.
- 🔄 Develop CI/CD pipelines and automation scripts against a real cluster.

---

## Kind

**kind** (Kubernetes IN Docker) runs Kubernetes clusters as Docker containers. It is widely used for testing Kubernetes itself or for local development. It’s lightweight and easy to use.

This script will install kind if not already installed and create a cluster based on a predefined `kind_cluster.yaml` configuration.

---

## K3d

**k3d** runs [k3s](https://k3s.io/) (a lightweight Kubernetes distribution) in Docker containers. k3d is optimized for speed and low resource usage, making it ideal for local development environments.

This script can also install k3d if missing and create a multi-agent cluster, with port mappings for easy service access.

---

## Dependencies

The script automatically installs the following dependencies using Nix package manager if they are missing:

- 🐳 `docker` — container runtime to run Kubernetes nodes.
- 🐙 `k3d` — lightweight Kubernetes distribution wrapper.
- 🧰 `kubectl` — Kubernetes command-line tool to interact with the cluster.
- 📦 `helm` — package manager for Kubernetes, used to install Traefik and other Helm charts.
- ❇️ **Nix** package manager

---

## Running

Inside of the `scripts/local_kubernetes_cluster/` directory, run:

```bash
./run.sh <cluster-name>
```


## Troubleshooting

- ⚠️ **CRD Errors:**  
  If you see errors about missing or conflicting CustomResourceDefinitions (CRDs) when installing Traefik, try uninstalling previous Traefik CRDs manually:

  ```bash
  kubectl delete crd ingressroutes.traefik.io
  kubectl delete crd middlewares.traefik.io
  # delete other traefik-related CRDs as needed
  ```

- 🛠 **Helm Ownership Metadata Errors:**  
    These occur if CRDs exist but Helm doesn’t “own” them. Deleting CRDs as above and reinstalling Traefik CRDs often fixes this.

- 🐞 **Pods not becoming Ready:**  
    Check pod status and logs with:

```
kubectl get pods -A
kubectl logs -n kube-system <pod-name>
```

- 🔐 **Permissions to modify /etc/hosts:**    
The script requires sudo privileges to modify /etc/hosts. Make sure you run the script in a terminal with sudo rights or enter your password when prompted.

- 🐳 **Docker permissions:**   
Ensure your user has permission to run Docker commands without sudo or run the script with appropriate privileges.
