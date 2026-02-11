# ☁️ Cloud-Native Architectures

Cloud-native is an approach to building and running applications that fully exploits the advantages of the cloud computing delivery model.

---

## 🎯 What is Cloud-Native?

According to the [Cloud Native Computing Foundation (CNCF)](https://www.cncf.io/), cloud-native technologies empower organizations to build and run scalable applications in modern, dynamic environments such as public, private, and hybrid clouds.

**Key Characteristics:**
- **Containers**: Lightweight, portable runtime environments
- **Microservices**: Loosely coupled, independently deployable services  
- **Dynamic Orchestration**: Automated management (e.g., Kubernetes)
- **DevOps/GitOps**: Continuous delivery and infrastructure as code

---

## 🏗️ Cloud-Native Architecture Patterns

### Microservices

Break applications into small, focused services that can be developed, deployed, and scaled independently.

```
┌─────────────────────────────────────────────────────────┐
│                      API Gateway                         │
└─────────────────────────────────────────────────────────┘
         │              │              │              │
    ┌────▼────┐   ┌────▼────┐   ┌────▼────┐   ┌────▼────┐
    │  User   │   │  Order  │   │ Payment │   │ Inventory│
    │ Service │   │ Service │   │ Service │   │ Service  │
    └────┬────┘   └────┬────┘   └────┬────┘   └────┬────┘
         │              │              │              │
    ┌────▼────┐   ┌────▼────┐   ┌────▼────┐   ┌────▼────┐
    │  User   │   │  Order  │   │ Payment │   │ Inventory│
    │   DB    │   │   DB    │   │   DB    │   │   DB     │
    └─────────┘   └─────────┘   └─────────┘   └─────────┘
```

### 12-Factor App

A methodology for building software-as-a-service apps:

| Factor | Description |
|--------|-------------|
| **Codebase** | One codebase tracked in version control |
| **Dependencies** | Explicitly declare and isolate dependencies |
| **Config** | Store config in the environment |
| **Backing Services** | Treat backing services as attached resources |
| **Build, Release, Run** | Strictly separate build and run stages |
| **Processes** | Execute the app as stateless processes |
| **Port Binding** | Export services via port binding |
| **Concurrency** | Scale out via the process model |
| **Disposability** | Maximize robustness with fast startup and graceful shutdown |
| **Dev/Prod Parity** | Keep development, staging, and production as similar as possible |
| **Logs** | Treat logs as event streams |
| **Admin Processes** | Run admin/management tasks as one-off processes |

---

## 🛠️ Cloud-Native Technologies

### Container Runtime

| Technology | Description |
|------------|-------------|
| **Docker** | Industry-standard container runtime |
| **containerd** | Lightweight container runtime |
| **Podman** | Daemonless container engine |

### Orchestration

| Technology | Description |
|------------|-------------|
| **Kubernetes** | Industry-standard container orchestration |
| **Nomad** | Simple, flexible workload orchestrator |
| **Docker Swarm** | Native Docker clustering |

### Service Mesh

| Technology | Description |
|------------|-------------|
| **Istio** | Feature-rich service mesh |
| **Linkerd** | Lightweight, security-focused mesh |
| **Cilium** | eBPF-powered networking and observability |

### Serverless

| Platform | Provider |
|----------|----------|
| **Azure Functions** | Microsoft Azure |
| **AWS Lambda** | Amazon Web Services |
| **Google Cloud Functions** | Google Cloud |
| **Knative** | Kubernetes-native serverless |

---

## 📊 Cloud-Native Maturity Model

| Level | Description |
|-------|-------------|
| **Level 1** | Containerized applications |
| **Level 2** | Container orchestration (Kubernetes) |
| **Level 3** | CI/CD automation and GitOps |
| **Level 4** | Observability and service mesh |
| **Level 5** | Full platform engineering with self-service |

---

## 🔗 Related Resources

- [Kubernetes](kubernetes.md)
- [Infrastructure as Code](iac.md)
- [Observability](observability/README.md)
- [CNCF Landscape](https://landscape.cncf.io/)
