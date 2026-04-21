# terrascaler chart

The [terrascaler chart](https://github.com/containeroo/helm-charts/tree/master/charts/terrascaler) installs Terrascaler, an external gRPC cloud provider for Kubernetes Cluster Autoscaler.

Terrascaler updates a configured integer field in a Terraform/OpenTofu repository through the GitLab API. The repository's GitLab CI pipeline can then apply the change and add Kubernetes worker nodes.

## Installation

```shell
helm repo add containeroo https://charts.containeroo.ch
helm install terrascaler containeroo/terrascaler \
  --set gitlab.project=platform/cluster-infra \
  --set gitlab.existingSecret=terrascaler-gitlab \
  --set terraform.file=main.tf \
  --set terraform.blockLabels='{hostedcluster}' \
  --set terraform.attribute=worker_count
```

Create the GitLab token secret first:

```shell
kubectl create secret generic terrascaler-gitlab --from-literal=token="$GITLAB_TOKEN"
```

## Cluster Autoscaler cloud config

Configure Cluster Autoscaler with `--cloud-provider=externalgrpc` and a cloud config similar to:

```yaml
address: terrascaler.default.svc.cluster.local:8080
grpc_timeout: 30s
```

## Configuration

The following table lists the configurable parameters of the terrascaler helm chart and their default values.

| Parameter | Default | Description |
| --- | --- | --- |
| `replicaCount` | `1` | Number of replicas |
| `image.repository` | `ghcr.io/containeroo/terrascaler` | Image repository |
| `image.pullPolicy` | `IfNotPresent` | Image pull policy |
| `image.tag` | `None` | Overrides the image tag of chart `appVersion` |
| `imagePullSecrets` | `[]` | Image pull secrets |
| `nameOverride` | `None` | Override chart name |
| `fullnameOverride` | `None` | Override full resource name |
| `serviceAccount.create` | `true` | If `true`, create a new service account |
| `serviceAccount.annotations` | `{}` | Additional ServiceAccount annotations |
| `serviceAccount.name` | `None` | ServiceAccount name to use |
| `service.type` | `ClusterIP` | Kubernetes Service type |
| `service.port` | `8080` | gRPC service port |
| `service.annotations` | `{}` | Additional Service annotations |
| `gitlab.baseURL` | `None` | GitLab base URL; empty uses GitLab.com |
| `gitlab.project` | `group/project` | GitLab project ID or path |
| `gitlab.branch` | `main` | Git branch to update |
| `gitlab.token` | `changeme` | GitLab API token; creates a Secret when set |
| `gitlab.existingSecret` | `None` | Existing Secret containing the GitLab API token |
| `gitlab.tokenKey` | `token` | Secret key containing the GitLab API token |
| `terraform.file` | `main.tf` | Terraform file path in the repository |
| `terraform.blockType` | `module` | Terraform block type containing the target field |
| `terraform.blockLabels` | `[hostedcluster]` | Terraform block labels |
| `terraform.attribute` | `worker_count` | Terraform integer attribute to update |
| `nodeGroup.id` | `hostedcluster-workers` | Cluster Autoscaler node group ID |
| `nodeGroup.minSize` | `0` | Node group minimum size |
| `nodeGroup.maxSize` | `100` | Node group maximum size |
| `templateNode.cpu` | `2` | Template node CPU capacity |
| `templateNode.memory` | `8Gi` | Template node memory capacity |
| `templateNode.pods` | `110` | Template node pod capacity |
| `templateNode.labels` | `{}` | Additional labels for the template node |
| `tls.existingSecret` | `None` | Existing Secret containing `tls.crt` and `tls.key`; enables server TLS |
| `tls.certKey` | `tls.crt` | TLS certificate key in `tls.existingSecret` |
| `tls.keyKey` | `tls.key` | TLS private key key in `tls.existingSecret` |
| `tls.clientCASecret` | `None` | Existing Secret containing a client CA bundle; enables mTLS |
| `tls.clientCAKey` | `ca.crt` | Client CA key in `tls.clientCASecret` |
| `extraArgs` | `[]` | Additional command line arguments |
| `extraEnv` | `[]` | Additional environment variables |
| `extraVolumes` | `[]` | Additional pod volumes |
| `extraVolumeMounts` | `[]` | Additional volume mounts for the terrascaler container |
| `podAnnotations` | `{}` | Additional pod annotations |
| `podLabels` | `{}` | Additional pod labels |
| `podSecurityContext` | `{}` | Pod security context |
| `securityContext` | restricted non-root defaults | Container security context |
| `openshift.enabled` | `false` | Use OpenShift restricted SCC compatible container security context |
| `openshift.securityContext` | restricted SCC compatible defaults | Container security context used when `openshift.enabled=true` |
| `resources.requests.cpu` | `50m` | CPU resource requests |
| `resources.requests.memory` | `64Mi` | Memory resource requests |
| `resources.limits.cpu` | `100m` | CPU resource limits |
| `resources.limits.memory` | `128Mi` | Memory resource limits |
| `nodeSelector` | `{}` | Node selector properties |
| `tolerations` | `[]` | Toleration properties |
| `affinity` | `{}` | Affinity properties |
