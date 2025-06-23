# 👀 Observability

Observability is about being able to understand, monitor, and improve systems by
observing them. Software systems are observed through telemetry data,
specifically: logs, metrics, and traces.

Once we have a human in the loop with some tools for alerts and visualizations, that observation is called
Monitoring.

---

## ✨ Key Concepts

- **Metrics**: Quantitative measurements (e.g., CPU, memory, request rates)
  about system or application performance.
- **Logs**: Structured or unstructured records of events and errors.
- **Traces**: End-to-end records of requests as they flow through distributed
  systems.
- **Visualization**: A visual representation of data that is more 
- **Dashboards**: Visual representations of system and application health.
- **Alerts**: Automated notifications triggered by threshold breaches or
  anomalies.
- **Uptime Monitoring**: Tracking service and endpoint availability.
- **Health Checks**: Automated tests to verify system components are
  functioning.

---

## 🛠️ Monitoring & Observability Tools Ecosystem

Popular tools and platforms include:

- **OpenTelemetry**: Vendor-neutral standard for collecting traces, metrics, and
  logs. OTel powers most modern observability solutions, providing a unified
  framework for telemetry data collection.
- **Prometheus**: Open-source metrics collection, monitoring, and alerting
  toolkit.
- **Grafana**: Visualization and dashboarding for metrics and logs.
- **Loki**: Log aggregation and querying.
- **Alertmanager**: Managing alerts and notifications.
- **Jaeger, Tempo, Zipkin**: Distributed tracing systems.
- **Datadog, New Relic, Dynatrace**: Commercial monitoring and observability
  platforms.
- **Cloud-native monitoring**: AWS CloudWatch, Azure Monitor, Google Cloud
  Monitoring.

For more, see the
[Platform Tooling Landscape](../platform_engineering_landscape.md).

---

## 🚦 Monitoring & Observability in Practice

- **Set up dashboards** for critical services and infrastructure.
- **Define alerting rules** for key metrics and error conditions.
- **Monitor uptime and latency** for user-facing endpoints.
- **Integrate monitoring with incident response** and on-call workflows.
- **Golden Signals**: Monitor latency, traffic, errors, and saturation for
  critical services.
- **SLOs & SLIs**: Define Service Level Objectives and Indicators to measure
  reliability.
- **Feedback Loops**: Use observability data to drive continuous improvement and
  incident response.
- **Integration**: Connect observability with CI/CD, alerting, and incident
  management workflows.

---

## 🚀 Getting Started with Monitoring & Observability

We recommend deploying Kubernetes Operators for most services as they provide a
modern and portable way to manage systems in a GitOps-friendly way. The simplest
observability solution is the `kube-prometheus-stack` distributed as a Helm
chart, which includes:

- **Prometheus**: For metrics collection and alerting.
- **Grafana**: For visualizing metrics and logs.
- **Loki**: For log aggregation and querying.
- **Alertmanager**: For managing alerts and notifications.


---

## 📚 Further Reading

- [Internal Developer Platforms](../internal_development_platforms.md)
- [Platform Engineering Landscape](../platform_engineering_landscape.md)

---

> _“Monitoring is the first line of defense for reliable platforms. You can’t
> fix what you can’t see.”_
