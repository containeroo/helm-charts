# cloudflare-operator chart

The [cloudflare-operator chart](https://github.com/containeroo/helm-charts/tree/master/charts/cloudflare-operator) provides a Helm chart as a first-class method of installation on Kubernetes.

## Installation

For a detailed installation guide, see the [cloudflare-operator documentation](https://containeroo.github.io/cloudflare-operator/installation/#steps).

## Configuration

The following tables lists the configurable parameters of cloudflare-operator helm chart and their default values.

| Parameter                    | Default                                   | Description                                           |
| ---------------------------- | ----------------------------------------- | ----------------------------------------------------- |
| `image.repository`           | `ghcr.io/containeroo/cloudflare-operator` | Image repository                                      |
| `image.pullPolicy`           | `IfNotPresent`                            | Image pull policy                                     |
| `image.tag`                  | `None`                                    | Overrides the image tag of chart `appVersion`         |
| `image.pullSecret`           | `None`                                    | Image pull secret                                     |
| `fullnameOverride`           | `None`                                    | Override the full name of resources                   |
| `serviceAccount.create`      | `true`                                    | If `true`, create a new service account               |
| `serviceAccount.annotations` | `{}`                                      | Additional Service Account annotations                |
| `serviceAccount.name`        | `cloudflare-operator`                     | Service account to be used                            |
| `clusterRole.create`         | `true`                                    | If `true`, create cluster role & cluster role binding |
| `clusterRole.name`           | `cloudflare-operator`                     | The name of a cluster role to bind to                 |
| `podAnnotations`             | `{}`                                      | Additional pod annotations                            |
| `podLabels`                  | `{}`                                      | Additional pod labels                                 |
| `securityContext`            | `{}`                                      | Adding `securityContext` options to the pod           |
| `resources.requests.cpu`     | `50m`                                     | CPU resource requests for the deployment              |
| `resources.requests.memory`  | `64Mi`                                    | Memory resource requests for the deployment           |
| `resources.limits.cpu`       | `None`                                    | CPU resource limits for the deployment                |
| `resources.limits.memory`    | `None`                                    | Memory resource limits for the deployment             |
| `livenessProbe.enabled`      | `true`                                    | If `true`, enables livenessProbe for the deployment   |
| `readinessProbe.enabled`     | `true`                                    | If `true`, enables readinessProbe for the deployment  |
| `nodeSelector`               | `{}`                                      | Node Selector properties for the deployment           |
| `tolerations`                | `[]`                                      | Tolerations properties for the deployment             |
| `affinity`                   | `{}`                                      | Affinity properties for the deployment                |

## Uninstall

For a detailed uninstall guide, see the [cloudflare-operator documentation](https://containeroo.github.io/cloudflare-operator/installation/#uninstalling).
