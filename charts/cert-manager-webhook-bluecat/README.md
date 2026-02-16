# cert-manager-webhook-bluecat chart

The [cert-manager-webhook-bluecat chart](https://github.com/containeroo/helm-charts/tree/master/charts/cert-manager-webhook-bluecat) installs the cert-manager DNS01 webhook for BlueCat Address Manager REST v2.

## Prerequisites

- Kubernetes cluster with [cert-manager](https://cert-manager.io/) installed
- cert-manager service account that can access this webhook API (defaults to `cert-manager` in namespace `cert-manager`)

## Installation

```shell
helm repo add containeroo https://charts.containeroo.ch
helm repo update
helm install cert-manager-webhook-bluecat containeroo/cert-manager-webhook-bluecat
```

## Configuration

The following table lists the configurable parameters of the `cert-manager-webhook-bluecat` chart and their default values.

| Parameter                        | Default                                            | Description                                                     |
| -------------------------------- | -------------------------------------------------- | --------------------------------------------------------------- |
| `groupName`                      | `bluecat.acme.containeroo.ch`                      | API group name used by the webhook solver                       |
| `certManager.namespace`          | `cert-manager`                                     | Namespace where cert-manager runs                               |
| `certManager.serviceAccountName` | `cert-manager`                                     | cert-manager service account that is granted solver access      |
| `image.repository`               | `ghcr.io/containeroo/cert-manager-webhook-bluecat` | Webhook container image repository                              |
| `image.pullPolicy`               | `IfNotPresent`                                     | Webhook container image pull policy                             |
| `image.tag`                      | `""`                                               | Overrides the image tag (chart `appVersion` is used when empty) |
| `nameOverride`                   | `""`                                               | Override the chart name                                         |
| `fullnameOverride`               | `""`                                               | Override the full resource name                                 |
| `service.type`                   | `ClusterIP`                                        | Service type                                                    |
| `service.port`                   | `443`                                              | Service port exposed inside the cluster                         |
| `service.containerPort`          | `10250`                                            | Container HTTPS port used by the webhook                        |
| `resources`                      | `{}`                                               | Pod resource requests and limits                                |
| `nodeSelector`                   | `{}`                                               | Node selector labels                                            |
| `tolerations`                    | `[]`                                               | Pod tolerations                                                 |
| `affinity`                       | `{}`                                               | Pod affinity rules                                              |

## Using The Webhook Solver

Configure your cert-manager `Issuer` or `ClusterIssuer` to use this webhook solver with the same `groupName` set in this chart.

```yaml
solvers:
  - dns01:
      webhook:
        groupName: bluecat.acme.containeroo.ch
        solverName: bluecat
```
