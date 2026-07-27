# Helm Chart Values for kube-ephemeral-container-exporter

This chart deploys kube-ephemeral-container-exporter. Prometheus Operator and Cilium resources are optional so the default installation works on a standard Kubernetes cluster.

## Installation

```bash
helm repo add containeroo https://charts.containeroo.ch
helm repo update containeroo
helm upgrade --install kube-ephemeral-container-exporter \
  containeroo/kube-ephemeral-container-exporter
```

## Important defaults

| Key                      | Description                                           | Default                                                 |
| ------------------------ | ----------------------------------------------------- | ------------------------------------------------------- |
| `namespace.create`       | Create the configured namespace resource.             | `false`                                                 |
| `image.repository`       | Exporter image repository.                            | `ghcr.io/containeroo/kube-ephemeral-container-exporter` |
| `image.tag`              | Exporter image tag. Empty uses the chart app version. | `""`                                                    |
| `image.pullPolicy`       | Image pull policy.                                    | `IfNotPresent`                                          |
| `replicas`               | Deployment replica count.                             | `1`                                                     |
| `leaderElection.enabled` | Enable controller leader election.                    | `true`                                                  |

## Watch scope

| Key | Description | Default |
| --- | --- | --- |
| `watch.currentNamespace` | Watch only the namespace containing the exporter Pod. | `false` |
| `watch.namespaces` | Namespaces to watch; one Role and RoleBinding is created in each. | `[]` |

When either namespace-scoped option is configured, the chart omits the
controller ClusterRole and ClusterRoleBinding and creates namespace-scoped
controller RBAC. Metrics authentication cluster RBAC remains independently
controlled by `metrics.rbac.create`.

## Deployment and pod values

| Key                      | Description                                             | Default                                            |
| ------------------------ | ------------------------------------------------------- | -------------------------------------------------- |
| `resources`              | Container resource requests and limits.                 | See `values.yaml`                                  |
| `podAnnotations`         | Pod annotations applied to the deployment.              | includes `kubectl.kubernetes.io/default-container` |
| `podLabels`              | Extra Pod labels.                                       | `{}`                                               |
| `podSecurityContext`     | Pod security context.                                   | `runAsNonRoot: true`                               |
| `securityContext`        | Container security context.                             | drop all caps, no privilege escalation             |
| `startupProbe.enabled`   | Enable startup probe.                                   | `false`                                            |
| `livenessProbe.enabled`  | Enable liveness probe.                                  | `true`                                             |
| `readinessProbe.enabled` | Enable readiness probe.                                 | `true`                                             |
| `probes.address`         | Override the health probe bind address.                 | `""`                                               |
| `server.enableHTTP2`     | Enable HTTP/2 for the metrics and probe servers.        | `false`                                            |
| `env`                    | Extra environment variables for the exporter container. | `[]`                                               |
| `extraArgs`              | Additional CLI arguments appended to the command.       | `[]`                                               |

## Monitoring values

| Key                                           | Description                                                         | Default                  |
| --------------------------------------------- | ------------------------------------------------------------------- | ------------------------ |
| `metrics.enabled`                             | Enable the metrics endpoint.                                        | `true`                   |
| `metrics.rbac.create`                         | Create HTTPS metrics authentication cluster RBAC.                   | `false`                  |
| `metrics.rbac.name`                           | Custom metrics authentication RBAC name.                            | `""`                     |
| `metrics.address`                             | Override the metrics bind address.                                  | `""`                     |
| `metrics.secure`                              | Serve metrics over HTTPS.                                           | `false`                  |
| `metrics.service.enabled`                     | Create the metrics Service.                                         | `true`                   |
| `metrics.serviceMonitor.enabled`              | Create the ServiceMonitor.                                          | `false`                  |
| `metrics.serviceMonitor.jobLabel`             | Service label used as the Prometheus `job`.                         | `app.kubernetes.io/name` |
| `metrics.prometheusRule.enabled`              | Create the PrometheusRule.                                          | `false`                  |
| `metrics.prometheusRule.namespace`            | Namespace for the PrometheusRule. Empty uses the release namespace. | `""`                     |
| `metrics.prometheusRule.exporterDown.enabled` | Alert when no healthy exporter target is scraped.                   | `true`                   |
| `metrics.prometheusRule.longRunning.enabled`  | Alert when an ephemeral container keeps running too long.           | `true`                   |
| `metrics.prometheusRule.longRunning.for`      | Duration before firing the long-running alert.                      | `1h`                     |

The ServiceMonitor includes a bearer token and TLS configuration only when
`metrics.secure` is enabled. Metrics authentication RBAC is likewise rendered
only when metrics, HTTPS, and `metrics.rbac.create` are all enabled.

## RBAC and networking values

| Key                                       | Description                                         | Default         |
| ----------------------------------------- | --------------------------------------------------- | --------------- |
| `clusterRole.create`                      | Create controller cluster RBAC in cluster-wide mode. | `true`         |
| `clusterRole.name`                        | Custom controller ClusterRole name.                 | `""`            |
| `role.create`                             | Explicitly create namespace-scoped controller RBAC. | `false`         |
| `role.name`                               | Custom controller Role name.                        | `""`            |
| `serviceAccount.create`                   | Create the ServiceAccount.                          | `true`          |
| `serviceAccount.annotations`              | ServiceAccount annotations.                         | `{}`            |
| `ciliumNetworkPolicy.enabled`             | Render the CiliumNetworkPolicy resources.           | `false`         |
| `ciliumNetworkPolicy.prometheusNamespace` | Namespace of the Prometheus pods allowed to scrape. | `observability` |

## Misc values

| Key                | Description                                       | Default |
| ------------------ | ------------------------------------------------- | ------- |
| `imagePullSecrets` | Image pull secrets for private registries.        | `[]`    |
| `nameOverride`     | Short name override.                              | `""`    |
| `fullnameOverride` | Full release name override.                       | `""`    |
| `extraObjects`     | Extra Kubernetes objects rendered with the chart. | `[]`    |
