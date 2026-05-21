# agent-forge-operator chart

The [agent-forge-operator chart](https://github.com/containeroo/helm-charts/tree/master/charts/agent-forge-operator) provides a Helm chart as a first-class method of installation on Kubernetes.

The chart installs the `VsphereAgent` and `VsphereAgentPool` CRDs from the chart `crds/` directory.

## Installation

```shell
helm repo add containeroo https://charts.containeroo.ch
helm install agent-forge-operator containeroo/agent-forge-operator --namespace agent-forge-operator-system --create-namespace
```

## Configuration

The following table lists the configurable parameters of the agent-forge-operator Helm chart and their default values.

| Parameter                                      | Default                                             | Description                                           |
| ---------------------------------------------- | --------------------------------------------------- | ----------------------------------------------------- |
| `image.repository`                             | `ghcr.io/containeroo/agent-forge-operator`          | Image repository                                      |
| `image.pullPolicy`                             | `IfNotPresent`                                      | Image pull policy                                     |
| `image.tag`                                    | `None`                                              | Overrides the image tag of chart `appVersion`         |
| `imagePullSecrets`                             | `[]`                                                | Image pull secrets                                    |
| `args`                                         | `["--leader-elect", "--health-probe-bind-address=:8081", "--metrics-bind-address=:8443"]` | Command line arguments to pass to the container |
| `nameOverride`                                 | `None`                                              | Override the chart name                               |
| `fullnameOverride`                             | `None`                                              | Override the full name of resources                   |
| `serviceAccount.create`                        | `true`                                              | If `true`, create a new service account               |
| `serviceAccount.annotations`                   | `{}`                                                | Additional Service Account annotations                |
| `serviceAccount.name`                          | `agent-forge-operator`                              | Service account to be used                            |
| `clusterRole.create`                           | `true`                                              | If `true`, create cluster role and cluster role binding |
| `clusterRole.name`                             | `agent-forge-operator`                              | The name of a cluster role to bind to                 |
| `clusterRole.extraRules`                       | `[]`                                                | Additional rules to be included in the role           |
| `leaderElectionRole.create`                    | `true`                                              | If `true`, create leader election role and role binding |
| `leaderElectionRole.name`                      | `agent-forge-operator-leader-election`              | The name of a leader election role to bind to         |
| `leaderElectionRole.extraRules`                | `[]`                                                | Additional rules to be included in the role           |
| `podAnnotations`                               | `{kubectl.kubernetes.io/default-container: agent-forge-operator}` | Additional pod annotations                  |
| `podSecurityContext`                           | `{runAsNonRoot: true, seccompProfile: {type: RuntimeDefault}}` | Pod-level security context                 |
| `securityContext`                              | `{allowPrivilegeEscalation: false, capabilities: {drop: [ALL]}}` | Container-level security context           |
| `resources.requests.cpu`                       | `10m`                                               | CPU resource requests for the deployment              |
| `resources.requests.memory`                    | `64Mi`                                              | Memory resource requests for the deployment           |
| `resources.limits.cpu`                         | `500m`                                              | CPU resource limits for the deployment                |
| `resources.limits.memory`                      | `128Mi`                                             | Memory resource limits for the deployment             |
| `metrics.service.enabled`                      | `true`                                              | Enable metrics service                                |
| `metrics.containerPort`                        | `8443`                                              | Metrics container port                                |
| `metrics.service.portName`                     | `https`                                             | Metrics service port name                             |
| `metrics.service.port`                         | `8443`                                              | Metrics service port                                  |
| `metrics.service.targetPort`                   | `metrics`                                           | Metrics service target port                           |
| `metrics.service.additionalLabels`             | `{}`                                                | Additional labels for the metrics service             |
| `metrics.authRole.create`                      | `true`                                              | Create authn/authz RBAC for secure metrics            |
| `metrics.authRole.name`                        | `agent-forge-operator-metrics-auth`                 | Metrics auth role name                                |
| `metrics.readerRole.create`                    | `false`                                             | Create a cluster role that can read `/metrics`        |
| `metrics.readerRole.name`                      | `agent-forge-operator-metrics-reader`               | Metrics reader role name                              |
| `metrics.serviceMonitor.enabled`               | `false`                                             | Enable ServiceMonitor                                 |
| `metrics.serviceMonitor.namespace`             | same as release namespace                           | Namespace for the ServiceMonitor                      |
| `metrics.serviceMonitor.additionalLabels`      | `{}`                                                | Additional labels for the ServiceMonitor              |
| `metrics.serviceMonitor.scrapeInterval`        | `60s`                                               | Scrape interval for the ServiceMonitor                |
| `metrics.serviceMonitor.scheme`                | `https`                                             | Metrics scrape scheme                                 |
| `metrics.serviceMonitor.bearerTokenFile`       | `/var/run/secrets/kubernetes.io/serviceaccount/token` | Bearer token file for secure metrics                |
| `metrics.serviceMonitor.tlsConfig`             | `{insecureSkipVerify: true}`                        | TLS config for the ServiceMonitor                     |
| `metrics.prometheusRule.enabled`               | `false`                                             | Enable PrometheusRule                                 |
| `metrics.prometheusRule.namespace`             | same as release namespace                           | Namespace for the PrometheusRule                      |
| `metrics.prometheusRule.additionalLabels`      | `{}`                                                | Additional labels for the PrometheusRule              |
| `livenessProbe.enabled`                        | `true`                                              | If `true`, enables livenessProbe for the deployment   |
| `readinessProbe.enabled`                       | `true`                                              | If `true`, enables readinessProbe for the deployment  |
| `nodeSelector`                                 | `{}`                                                | Node Selector properties for the deployment           |
| `tolerations`                                  | `[]`                                                | Tolerations properties for the deployment             |
| `affinity`                                     | `{}`                                                | Affinity properties for the deployment                |
| `sidecars`                                     | `[]`                                                | Add additional sidecar containers to the operator pod |

## CRD Upgrades

Helm installs CRDs from the chart `crds/` directory on first install, but does not upgrade or delete CRDs during normal chart upgrades. Apply updated CRDs explicitly before upgrading between Agent Forge Operator versions that change CRD schemas.
