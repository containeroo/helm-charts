# cloudflare-operator chart

The [cloudflare-operator chart](https://github.com/containeroo/helm-charts/tree/master/charts/cloudflare-operator) provides a Helm chart as a first-class method of installation on Kubernetes.

## Installation

For a detailed installation guide, see the [cloudflare-operator documentation](https://docs.cf.containeroo.ch/installation/#installing-with-helm).

## Configuration

The following tables lists the configurable parameters of cloudflare-operator helm chart and their default values.

| Parameter                                 | Default                                   | Description                                           |
| ----------------------------------------- | ----------------------------------------- | ----------------------------------------------------- |
| `image.repository`                        | `ghcr.io/containeroo/cloudflare-operator` | Image repository                                      |
| `image.pullPolicy`                        | `IfNotPresent`                            | Image pull policy                                     |
| `image.tag`                               | `None`                                    | Overrides the image tag of chart `appVersion`         |
| `image.pullSecret`                        | `None`                                    | Image pull secret                                     |
| `fullnameOverride`                        | `None`                                    | Override the full name of resources                   |
| `serviceAccount.create`                   | `true`                                    | If `true`, create a new service account               |
| `serviceAccount.annotations`              | `{}`                                      | Additional Service Account annotations                |
| `serviceAccount.name`                     | `cloudflare-operator`                     | Service account to be used                            |
| `clusterRole.create`                      | `true`                                    | If `true`, create cluster role & cluster role binding |
| `clusterRole.name`                        | `cloudflare-operator`                     | The name of a cluster role to bind to                 |
| `podAnnotations`                          | `{}`                                      | Additional pod annotations                            |
| `podLabels`                               | `{}`                                      | Additional pod labels                                 |
| `securityContext`                         | `{}`                                      | Adding `securityContext` options to the pod           |
| `resources.requests.cpu`                  | `50m`                                     | CPU resource requests for the deployment              |
| `resources.requests.memory`               | `64Mi`                                    | Memory resource requests for the deployment           |
| `resources.limits.cpu`                    | `None`                                    | CPU resource limits for the deployment                |
| `resources.limits.memory`                 | `None`                                    | Memory resource limits for the deployment             |
| `metrics.podMonitor.enabled`              | `false`                                   | Enable pod monitor                                    |
| `metrics.podMonitor.namespace`            | same as release namespace                 | Namespace for the pod monitor                         |
| `metrics.podMonitor.additionalLabels`     | `{}`                                      | Additional labels for the pod monitor                 |
| `metrics.podMonitor.scrapeInterval`       | `60s`                                     | Scrape interval for the pod monitor                   |
| `metrics.prometheusRule.enabled`          | `false`                                   | Enable prometheus rule                                |
| `metrics.prometheusRule.namespace`        | same as release namespace                 | Namespace for the prometheus rule                     |
| `metrics.prometheusRule.additionalLabels` | `{}`                                      | Additional labels for the prometheus rule             |
| `livenessProbe.enabled`                   | `true`                                    | If `true`, enables livenessProbe for the deployment   |
| `readinessProbe.enabled`                  | `true`                                    | If `true`, enables readinessProbe for the deployment  |
| `nodeSelector`                            | `{}`                                      | Node Selector properties for the deployment           |
| `tolerations`                             | `[]`                                      | Tolerations properties for the deployment             |
| `affinity`                                | `{}`                                      | Affinity properties for the deployment                |

## Uninstall

For a detailed uninstall guide, see the [cloudflare-operator documentation](https://docs.cf.containeroo.ch/installation/#uninstalling-with-helm).

## Upgrade Notes

## From v0.0.x to v0.1.0

The apiVersion of the cloudflare-operator CRDs changed from `cf.containeroo.ch/v1alpha1` to `cf.containeroo.ch/v1beta1`.  
Please update your CRDs to `cf.containeroo.ch/v1beta1` before upgrading to `v0.1.0`:

```shell
kubectl apply --server-side -f https://github.com/containeroo/cloudflare-operator/releases/download/v0.1.0/crds.yaml
```
