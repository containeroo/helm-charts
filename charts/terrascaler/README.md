# terrascaler chart

The [terrascaler chart](https://github.com/containeroo/helm-charts/tree/master/charts/terrascaler) installs Terrascaler, a reduced Kubernetes autoscaler backed by GitLab and Terraform/OpenTofu.

Terrascaler watches Kubernetes nodes and pods directly. When eligible pending pods do not fit on current worker capacity, it commits a larger Terraform worker count to GitLab. The repository's GitLab CI pipeline can then apply the change and add Kubernetes worker nodes.

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
| `autoscaling.checkInterval` | `1m` | Autoscaling check interval |
| `autoscaling.scaleUpCooldown` | `5m` | Minimum time between scale-up commits |
| `autoscaling.pendingPodMinAge` | `30s` | Minimum age for pending pods without an Unschedulable condition |
| `autoscaling.dryRun` | `false` | Log scale-up decisions without updating GitLab |
| `metrics.enabled` | `true` | Expose Prometheus metrics on `/metrics` |
| `metrics.port` | `8080` | Metrics port |
| `metrics.service.annotations` | `{}` | Additional metrics Service annotations |
| `metrics.podMonitor.enabled` | `false` | Create a Prometheus Operator PodMonitor |
| `metrics.podMonitor.namespace` | same as release namespace | Namespace for the PodMonitor |
| `metrics.podMonitor.additionalLabels` | `{}` | Additional PodMonitor labels |
| `metrics.podMonitor.scrapeInterval` | `60s` | PodMonitor scrape interval |
| `metrics.prometheusRule.enabled` | `false` | Create a PrometheusRule for scale-down potential |
| `metrics.prometheusRule.namespace` | same as release namespace | Namespace for the PrometheusRule |
| `metrics.prometheusRule.additionalLabels` | `{}` | Additional PrometheusRule labels |
| `metrics.prometheusRule.for` | `30m` | Alert duration before firing |
| `metrics.prometheusRule.labels` | `{severity: warning}` | Alert labels |
| `metrics.prometheusRule.annotations` | scale-down summary and description | Alert annotations |
| `clusterRole.create` | `true` | If `true`, create ClusterRole and ClusterRoleBinding for node/pod reads |
| `clusterRole.name` | `None` | ClusterRole name to use |
| `clusterRole.extraRules` | `[]` | Additional ClusterRole rules |
| `gitlab.baseURL` | `None` | GitLab base URL; empty uses GitLab.com |
| `gitlab.project` | `group/project` | GitLab project ID or path |
| `gitlab.branch` | `main` | Git branch to update |
| `gitlab.token` | `changeme` | GitLab API token; creates a Secret when set |
| `gitlab.existingSecret` | `None` | Existing Secret containing the GitLab API token |
| `gitlab.tokenKey` | `token` | Secret key containing the GitLab API token |
| `gitlab.mergeRequest.enabled` | `false` | Create merge requests instead of committing directly to the target branch |
| `gitlab.mergeRequest.branchPrefix` | `terrascaler/scale` | Source branch prefix for merge request mode |
| `gitlab.mergeRequest.title` | `terrascaler: scale worker count` | Merge request title |
| `gitlab.mergeRequest.description` | automated proposal text | Merge request description prefix |
| `gitlab.mergeRequest.labels` | `[terrascaler]` | Merge request labels |
| `gitlab.mergeRequest.assigneeIDs` | `[]` | GitLab numeric user IDs to assign |
| `gitlab.mergeRequest.reviewerIDs` | `[]` | GitLab numeric user IDs to request review from |
| `gitlab.mergeRequest.removeSourceBranch` | `true` | Remove source branch after merge |
| `terraform.file` | `main.tf` | Terraform file path in the repository |
| `terraform.blockType` | `module` | Terraform block type containing the target field |
| `terraform.blockLabels` | `[hostedcluster]` | Terraform block labels |
| `terraform.attribute` | `worker_count` | Terraform integer attribute to update |
| `scaling.minSize` | `0` | Minimum target size |
| `scaling.maxSize` | `100` | Maximum target size |
| `scaling.nodeSelector` | `{}` | Node labels identifying Terraform-managed workers |
| `templateNode.cpu` | `2` | New worker CPU capacity |
| `templateNode.memory` | `8Gi` | New worker memory capacity |
| `templateNode.pods` | `110` | New worker pod capacity |
| `templateNode.labels` | `{}` | Reserved metadata for new worker labels |
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
| `nodeSelector` | `{}` | Node selector properties for the Terrascaler pod |
| `tolerations` | `[]` | Toleration properties |
| `affinity` | `{}` | Affinity properties |
