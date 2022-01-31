# cloudflare-operator chart

The [cloudflare-operator chart](https://github.com/containeroo/helm-charts/tree/master/charts/cloudflare-operator) provides a Helm chart as a first-class method of installation on Kubernetes.

## Installation

Add the containeroo Helm repository:

```bash
helm repo add containeroo https://charts.containeroo.ch
```

Update your local Helm chart repository cache:

```bash
helm repo update
```

Install CustomResourceDefinitions:

```bash
kubectl apply -f https://github.com/containeroo/cloudflare-operator/releases/download/v0.0.5/crds.yaml
```

Install cloudflare-operator:

```bash
helm install \
  cloudflare-operator containeroo/cloudflare-operator \
  --namespace cloudflare-operator \
  --create-namespace
```

## Configuration

The following tables lists the configurable parameters of cloudflare-operator helm chart and their default values.

| Parameter                                         | Default                                              | Description
| -----------------------------------------------   | ---------------------------------------------------- | ---
| `image.repository`                                | `ghcr.io/containeroo/cloudflare-operator`            | Image repository
| `image.pullPolicy`                                | `IfNotPresent`                                       | Image pull policy
| `image.tag`                                       | `None`                                               | Overrides the image tag of chart `appVersion`
| `image.pullSecret`                                | `None`                                               | Image pull secret
| `fullnameOverride`                                | `None`                                               | Override the full name of resources
| `rbac.create`                                     | `true`                                               | If `true`, create and use RBAC resources
| `serviceAccount.create`                           | `true`                                               | If `true`, create a new service account
| `serviceAccount.annotations`                      | `{}`                                                 | Additional Service Account annotations
| `serviceAccount.name`                             | `cloudflare-operator`                                | Service account to be used
| `podAnnotations`                                  | `{}`                                                 | Additional pod annotations
| `podLabels`                                       | `{}`                                                 | Additional pod labels
| `securityContext`                                 | `{}`                                                 | Adding `securityContext` options to the pod
| `resources.requests.cpu`                          | `50m`                                                | CPU resource requests for the deployment
| `resources.requests.memory`                       | `64Mi`                                               | Memory resource requests for the deployment
| `resources.limits.cpu`                            | `None`                                               | CPU resource limits for the deployment
| `resources.limits.memory`                         | `None`                                               | Memory resource limits for the deployment
| `livenessProbe.enabled`                           | `true`                                               | If `true`, enables livenessProbe for the deployment
| `readinessProbe.enabled`                          | `true`                                               | If `true`, enables readinessProbe for the deployment
| `nodeSelector`                                    | `{}`                                                 | Node Selector properties for the deployment
| `tolerations`                                     | `[]`                                                 | Tolerations properties for the deployment
| `affinity`                                        | `{}`                                                 | Affinity properties for the deployment

### Uninstall

To uninstall/delete cloudflare-operator Helm release:

```sh
helm delete --purge cloudflare-operator
```

The command removes all the Kubernetes components associated with the chart and
deletes the release.

!!! warning
    This command will also remove installed cloudflare-operator CRDs. All cloudflare-operator resources (e.g. `DNSRecord.cloudflare-operator.containeroo.ch` resources) will be removed by Kubernetes' garbage collector.

```bash
kubectl delete -f https://github.com/containeroo/cloudflare-operator/releases/download/v0.0.5/crds.yaml
```
